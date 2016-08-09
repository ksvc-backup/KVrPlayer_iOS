//
//  KSYVRPlayerController.h
//  TestForKSYVRPlayer
//
//  Created by mayudong on 16/7/18.
//  Copyright © 2016年 mayudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KSYMediaPlayer/KSYMediaPlayer.h>

/**
 * 调整视角使用的交互模式
 */
typedef NS_ENUM(NSInteger, KSYVRModeInteractive) {
    /// 使用触摸的方式调整视角
    KSYVRModeInteractiveTouch,
    /// 运动识别方式调整视角
    KSYVRModeInteractiveMotion,
    /// 触摸和运动方式一起生效
    KSYVRModeInteractiveMotionWithTouch,
};

/**
 * 显示模式
 */
typedef NS_ENUM(NSInteger, KSYVRModeDisplay) {
    /// 单目模式
    KSYVRModeDisplayNormal,
    /// 双目左右模式
    KSYVRModeDisplayGlass,
};

/**
 * KSYVRPlayerController
 * 继承自金山云播放SDK中的KSYMoviePlayerController类，在支持原有功能的基础上实现了VR播放功能,
 * 所以需要依赖金山云播放SDK
 */
@interface KSYVRPlayerController : KSYMoviePlayerController

/**
 当前使用的交互模式
 @see KSYVRModeInteractive
 */
@property (nonatomic, readonly) KSYVRModeInteractive iMode;

/**
 当前使用的显示模式
 @see KSYVRModeDisplay
 */
@property (nonatomic, readonly) KSYVRModeDisplay dMode;


/**
 @abstract 初始化播放器并设置播放地址
 @param url 视频播放地址，该地址可以是本地地址或者服务器地址.
 @return 返回KSYVRPlayerController对象，该对象的视频播放地址ContentURL已经初始化。此时播放器状态为MPMoviePlaybackStateStopped.
 
 @discussion 该方法初始化了播放器，并设置了播放地址。但是并没有将播放器对视频文件进行初始化，需要调用 [prepareToPlay]方法对视频文件进行初始化。
 @discussion 当前支持的协议包括：
 
 * http
 * rtmp
 * file, 本地文件
 
 @warning 必须调用该方法进行初始化，不能调用init方法。
 @since Available in KSYVRPlayerController 1.0 and later.
 @warning KSYMoviePlayerController 当前版本只支持单实例的KSYMoviePlayerController对象，多实例将导致播放异常。
 */

- (instancetype)initWithContentURL:(NSURL *)url;

/**
 @abstract 获取版本号
 @return NSString类型的版本号字符串
 @discussion 使用[getVersion]函数获取播放器SDK版本号
 @since Available in KSYVRPlayerController 1.0 and later.
 */
- (NSString *)getVRVersion;

/**
 @abstract 初始化VR播放的交互模式和显示模式
 @param iMode 交互模式
 @param dMode 显示模式
 @return 无返回值
 
 @discussion 该函数为初始化设置，需要在setContainer:view:函数之前调用，之后需要修改交互和显示模式时，需要调用
             [setInteractiveMode:]和[setDisplayMode:]
 @warning 因为VR播放使用了KSYMoviePlayerController的videoDataBlock属性，所以不可再设置videoDataBlock属性，否则会影响VR视频的渲染
 @since Available in KSYVRPlayerController 1.0 and later.
 @see KSYVRModeInteractive
 @see KSYVRModeDisplay
 */
- (void)initVRMode:(KSYVRModeInteractive)iMode dispalyMode:(KSYVRModeDisplay)dMode;

/**
 @abstract 设置播放器的容器
 @param vc 播放器所在的ViewController
 @param view 播放器所在的View
 @return 无返回值
 
 @since Available in KSYVRPlayerController 1.0 and later.
 */
- (void) setContainer:(UIViewController*)vc view:(UIView*)view;

/**
 @abstract 设置VR播放的交互模式
 @param iMode 交互模式
 @return 无返回值
 
 @since Available in KSYVRPlayerController 1.0 and later.
 */
- (void)setInteractiveMode:(KSYVRModeInteractive)iMode;

/**
 @abstract 设置VR播放的显示模式
 @param dMode 显示模式
 @return 无返回值
 
 @since Available in KSYVRPlayerController 1.0 and later.
 */
- (void)setDisplayMode:(KSYVRModeDisplay)dMode;


/**
 @abstract 结束当前视频的播放。
 @discussion stop调用逻辑：
 
 * 调用stop结束当前播放，如果需要重新播放该视频，需要调用[prepareToPlay]([KSYMediaPlayback prepareToPlay])方法。
 * 调用stop方法后，播放器开始进入关闭当前播放的操作，操作完成将发送MPMoviePlayerPlaybackDidFinishNotification通知。
 
 @since Available in KSYVRPlayerController 1.0 and later.
*/
- (void)stop;

@end
