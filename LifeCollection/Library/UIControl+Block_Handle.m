//
//  UIControl+Category.m
//  TestProject
//
//  Created by LY on 2017/1/19.
//  Copyright © 2017 LY. All rights reserved.
//

#import "UIControl+Block_Handle.h"
#import <objc/runtime.h>

#define kMyAssert(condition, string, callback, goback)    \
if (!(condition))\
{\
    NSLog(@"[Debug]%s %@", __PRETTY_FUNCTION__, (string));\
    callback(); \
    if (goback) \
    {\
        return ;\
    }\
}

#pragma mark - control拓展-->事件通过block回调
@implementation UIControl (Block_Handle)

#pragma mark - public functions
- (void)handleControlEvents:(UIControlEvents)events withBlock:(UIControlActionBlock)block
{
    UIControlEvents clash = [self checkEventsClash:events];
    if (clash)
    {
        __weak typeof(self) weakself = self;
        void (^back)(void) = ^{
            [weakself removeHandleForControlEvents:events];
        };
        NSString *string = [NSString stringWithFormat:@"event block clash:%lu", (unsigned long)clash];
        kMyAssert(false, string, back, NO);
    }
    NSMutableDictionary *recordDic = [self blockDictionaryRecords];
    [recordDic setObject:block forKey:[NSNumber numberWithUnsignedInteger:events]];
}

- (void)removeHandleForControlEvents:(UIControlEvents)events
{
    NSMutableDictionary *recordDic = [self blockDictionaryRecords];
    NSNumber *key = [NSNumber numberWithUnsignedInteger:events];
    UIControlActionBlock block = recordDic[key];
    if (block != NULL)
    {
        [recordDic removeObjectForKey:key];
        return;
    }
    NSArray *keys = [recordDic allKeys];
    for (NSNumber *ok in keys)
    {
        UIControlEvents evt = [ok unsignedIntegerValue] & events;
        if (evt == 0)
        {
            continue;
        }
        UIControlActionBlock block = recordDic[ok];
        [recordDic removeObjectForKey:ok];
        
        UIControlEvents nkey = [ok unsignedIntegerValue] - evt;
        if (nkey == 0)
        {
            continue;
        }
        NSNumber *nk = [NSNumber numberWithUnsignedInteger:nkey];
        [recordDic setObject:block forKey:nk];
    }
}

#pragma mark - event response --> 回调block
- (void)callActionBlockWithEvent:(UIControlEvents)event
{
    NSMutableDictionary *recordDic = [self blockDictionaryRecords];
    NSArray *keys = [recordDic allKeys];
    NSNumber *thekey = nil;
    for (NSNumber *key in keys)
    {
        NSUInteger evt = [key unsignedIntegerValue];
        if (evt & event)
        {
            thekey = key;
            break;
        }
    }
    if (!thekey)
    {
        return;
    }
    UIControlActionBlock block = [recordDic objectForKey:thekey];
    if (block)
    {
        block(event);
    }
}

#pragma mark - event actions selector
- (void)touchDown:(UIControl *)sender
{
    [self callActionBlockWithEvent:UIControlEventTouchDown];
}

- (void)touchDownRepeat:(UIControl *)sender
{
    [self callActionBlockWithEvent:UIControlEventTouchDownRepeat];
}

- (void)touchDragInside:(UIControl *)sender
{
    [self callActionBlockWithEvent:UIControlEventTouchDragInside];
}

- (void)touchDragOutside:(UIControl *)sender
{
    [self callActionBlockWithEvent:UIControlEventTouchDragOutside];
}

- (void)touchDragEnter:(UIControl *)sender
{
    [self callActionBlockWithEvent:UIControlEventTouchDragEnter];
}

- (void)touchDragExit:(UIControl *)sender
{
    [self callActionBlockWithEvent:UIControlEventTouchDragExit];
}

- (void)touchUpInside:(UIControl *)sender
{
    [self callActionBlockWithEvent:UIControlEventTouchUpInside];
}

- (void)touchUpOutside:(UIControl *)sender
{
    [self callActionBlockWithEvent:UIControlEventTouchUpOutside];
}

- (void)touchCancel:(UIControl *)sender
{
    [self callActionBlockWithEvent:UIControlEventTouchCancel];
}

- (void)touchValueChanged:(UIControl *)sender
{
    [self callActionBlockWithEvent:UIControlEventValueChanged];
}

- (void)primaryActionTriggered:(UIControl *)sender
{
#ifdef __IPHONE_9_0
    [self callActionBlockWithEvent:UIControlEventPrimaryActionTriggered];
#endif
}

- (void)editingDidBegin:(UIControl *)sender
{
    [self callActionBlockWithEvent:UIControlEventEditingDidBegin];
}

- (void)editingChanged:(UIControl *)sender
{
    [self callActionBlockWithEvent:UIControlEventEditingChanged];
}

- (void)editingDidEnd:(UIControl *)sender
{
    [self callActionBlockWithEvent:UIControlEventEditingDidEnd];
}

- (void)editingDidEndOnExit:(UIControl *)sender
{
    [self callActionBlockWithEvent:UIControlEventEditingDidEndOnExit];
}

#pragma mark - 检测事件冲突
- (UIControlEvents)checkEventsClash:(UIControlEvents)events
{
    NSMutableDictionary *recordDic = [self blockDictionaryRecords];
    UIControlEvents clash = 0;
    NSArray *keys = [recordDic allKeys];
    
    for (NSInteger i = 0; i < 14; i ++)
    {
        NSUInteger bit = 1 << i;
        NSUInteger res = bit & events;
        if (res == 0)
        {
            continue;
        }
        for (NSNumber *key in keys)
        {
            NSUInteger evt = [key unsignedIntegerValue];
            NSUInteger value = evt & bit;
            if (value != 0)
            {
                clash = bit;
                break;
            }
        }
        if (clash)
        {
            break;
        }
    }
    return clash;
}

#pragma mark - runtime block记录容器:可变字典
- (NSMutableDictionary *)blockDictionaryRecords
{
    NSMutableDictionary *bdrd = (NSMutableDictionary *)objc_getAssociatedObject(self, @"block record");
    if (!bdrd)
    {
        NSMutableDictionary *mudic = [NSMutableDictionary dictionaryWithCapacity:1];
        objc_setAssociatedObject(self, @"block record", mudic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        bdrd = (NSMutableDictionary *)objc_getAssociatedObject(self, @"block record");
        [self addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchDownRepeat:) forControlEvents:UIControlEventTouchDownRepeat];
        [self addTarget:self action:@selector(touchDragInside:) forControlEvents:UIControlEventTouchDragInside];
        [self addTarget:self action:@selector(touchDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
        [self addTarget:self action:@selector(touchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        [self addTarget:self action:@selector(touchDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [self addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(touchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchCancel];
        [self addTarget:self action:@selector(touchValueChanged:) forControlEvents:UIControlEventValueChanged];
#ifdef __IPHONE_9_0
        [self addTarget:self action:@selector(primaryActionTriggered:) forControlEvents:UIControlEventPrimaryActionTriggered];
#endif
        [self addTarget:self action:@selector(editingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
        [self addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addTarget:self action:@selector(editingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        [self addTarget:self action:@selector(editingDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    }
    return bdrd;
}

@end

