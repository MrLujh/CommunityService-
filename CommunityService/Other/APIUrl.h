//
//  APIUrl.h
//  CommunityService
//
//  Created by 家浩 on 2016/12/10.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#ifndef APIUrl_h
#define APIUrl_h


/**
 * 配置文件
 */

#define KAPIGetCommen          @"m=ApiServer&a=get_common"    //获取配置列表

/**
 *  用户相关
 */

#define kAPIReg                @"m=ApiImeiUsers&a=reg_v3" //注册

#define kAPILogin              @"m=ApiImeiUsers&a=login_v2"

#define kAPILogout             @"m=Apishop&a=loginout"

#define kAPINoLogin            @"m=ApiImeiUsers&a=imeireg"   //imeid

#define kAPIGetNOLoginUserId   @"m=ApiImeiUsers&a=no_reg" //获取无登陆userId

#define kAPIGetUserInfo        @"m=Apicust&a=myuser" //用户信息

#define kAPIEditUserInfo       @"m=Apicust&a=nameedit" //设置中修改用户信息

#define kAPIGetCode            @"m=Apicust&a=getauth_v2" //注册用户获取验证码

#define kAPIGetUserInfo3       @"m=ApiImeiUsers&a=get_userinfo" //获取用户信息 >3.3版本

#define kAPICheckUID           @"m=ApiImeiUsers&a=is_userinfo_id" //检查uid是否正确

#define kAPIAddUserLocation    @"m=ApiImeiUsers&a=set_user_address" //上传经纬度

#define kAPIAddressList        @"m=ApiImeiReceipt&a=receiptlist"

#define kAPIAddressAdd         @"m=ApiImeiReceipt&a=receiptadd_v2"  //添加地址

#define kAPIAddressEdit        @"m=ApiImeiReceipt&a=receiptedit_v2"   //修改收货地址

#define kAPISetDefaultAddress  @"m=ApiImeiReceipt&a=receiptdefa" //设置位默认地址

#define kAPIAddressDelete      @"m=ApiImeiReceipt&a=receiptdel"  //删除收货地址

#define kAPIUploadImage        @"m=ApiUsersTwo&a=uphead"

#define kAPIGetCurrentCity     @"m=ApiCommunityTwo&a=getGPScid" //根据经纬度 获取当前城市

#define kAPIGetCommId          @"m=ApiAuout&a=get_home_auout_v3"    //获取广告列表
#define kAPIHomeActiviteList   @"m=ApiAuout&a=home_active_list" //发现优品、本地生活、理财专区

//#define kAPIGetShopTypes     @"m=Apicust&a=shopstype"   //获取商家分类：餐饮，服务，百货 等
//#define kAPIGetShopTypes     @"m=Apishop&a=get_shops_type_list"
#define kAPIGetShopTypes       @"m=Apishop&a=get_shops_type_list_custom"

#define kAPIFenghuangbaoBao    @"m=Apishop&a=shops_type_goto"//首页-凤凰宝

#define kAPIHomeBank           @"m=ApiAuout&a=home_bank_jump"//新加 首页-凤凰宝、理财

#define kAPIFenghuangeuser     @"m=ApiPay&a=rcblogin_v2"//我的—凤凰e账户

#define kAPILinkShop           @"m=ApiShopTwo&a=link_shop"//链接店铺地址

//首页、搜索、收藏的店铺列表
//#define kAPIGetShopList        @"m=ApiShopTwo&a=shoplist_v6"//首页商铺列表
#define kAPIGetShopList          @"m=ApiShopTwo&a=shoplist_cache"//首页商铺列表
#define kAPIAttenShopList        @"m=ApiShopTwo&a=my_atten_shoplist"//我的收藏列表



/*
 * 卡券相关
 */
#define kAPIAddVoucher              @"m=ApiCoupon&a=add_coupons_code"  //添加券(礼品券+代金券)
#define kAPIVoucherList             @"m=ApiCoupon&a=get_all_coupon_list"  //获取卡券列表
#define kAPIVoucherGiftDetail       @"m=ApiCoupon&a=gift_coupon_detail"  //获取礼品券详情
#define kAPIVoucherApplyGiftShopsList       @"m=ApiCoupon&a=gift_coupon_shops_list" //获取符合礼品券的商家表
#define kAPIAddVoucher2              @"m=ApiCoupon&a=add_coupon_v2"  //添加代金券


/*
 * 卡包相关
 */

#define kAPIKaBaoSortShopList         @"m=Card&a=sort_shoplist"  //有卡包的店铺的排序条件
#define kAPIKaBaoShopList             @"m=Card&a=card_shoplist"  //有卡包的店铺列表
#define kAPIKaBaoShopCardList         @"m=Card&a=shop_card_list" //商铺可以出售的会员卡列表
#define kAPIKaBaoUserCardList         @"m=Card&a=user_card_list"    //用户会员卡列表
#define kAPIKaBaoShopCardDetail       @"m=Card&a=card_detail" //商铺会员卡详情
#define kAPIKaBaoUserCardDetail       @"m=Card&a=user_card_detail"    //用户会员卡卡详情
#define kAPIKaBaoPaymentCode          @"m=Card&a=get_user_pay_code"    //获取付款码
#define kAPIKaBaoUserShoppingList     @"m=Card&&a=spend_card_list"    //用户消费列表
#define kAPIKaBaoUserShoppingDetail   @"m=Card&&a=spend_card_detail"  //用户消费详情
#define kAPIKaBaoPaymentCode2         @"m=Card&a=set_user_pay_code"

#define kAPIKaBaoWriteOrder           @"m=ApiImeiOrder&a=addorder_card"

#define kAPIKabaoWeixinPayResult      @"m=ApiImeiOrder&a=see_order_card"


//发现
#define kAPIFindGoods                 @"m=Apicust&a=find_goods_v2"   //发现 (4.0.5)
//#define kAPIFindGoods                 @"m=Apicust&a=find_goods"   //发现(4.0.5 之前)
#define kAPIFindGoodsDetail           @"m=Apicust&a=find_goods_detail_v2"       //发现商品详情
#define kAPIFindGoodsShareInfo        @"m=ApiShare&a=find_goods_share_content"   //发现商品提交订单后分享获取分享数据


/**
 *  商铺
 */

#define kAPIGetFavoriteShopList       @"m=ApiAttentionTwo&a=attenlist"    //口袋模块，获取收藏的商店列表

#define kAPIGetGoodCatesInShop        @"m=Apicust&a=goodstype"            //获取某一商店的左侧的商品分类：全部，水果...

#define kAPIGetGoodListsInShop        @"m=Apicust&a=goods"                //获取某一商店的右侧的商品列表

#define kAPIGetShopDetail             @"m=ApiShopTwo&a=detail_v4"         //商铺详情

#define kAPIGetSearchList             @"m=ApiSearchTwo&a=searchlist"      //搜索接口

#define kAPIShopSortList              @"m=ApiShopTwo&a=sort_shoplist"     //商铺排序列表

#define kAPIGetGoodList               @"m=Apicust&a=goods_list"           //获取某一商店的商品列表

/**
 *  行政区域
 *
 */
//取当前城市的社区
#define kAPIGetCountryListByCityIdOld      @"m=ApiCommunityTwo&a=pidcomm"  //取当前城市的社区
//取当前城市的社区
#define kAPIGetCountryListByCityId         @"m=ApiCommunity&a=get_community_list"

//添加我的社区
#define kAPIAddMyCommunity                 @"m=ApiUsers&a=addMyFavCommunity"
//获取我的社区列表
#define kAPIGetCommunityList               @"m=ApiUsers&a=getMyFavCommunity"
//删除社区
#define kAPIDeleteCommunityById            @"m=ApiUsers&a=delMyFavCommunity"

/**
 *  消息
 
 */

#define kAPIGetMessageType                @"m=Apicust&a=infortype"   //获取消息类型 ：官方，订单

#define kAPIGetMessageList                @"m=Apicust&a=inforlist"   //获取消息列表

#define kAPIGetMessageDetail              @"m=Apicust&a=inforshow" //获取官方消息详情

#define kAPIGetMsgList                    @"m=Apicust&a=my_inforlist"  //获取消息列表(new)


/*
 
 */

#define kAPIGetVersion                   @"m=Apicust&a=get_version"

/**
 *  下订单
 */

#define kAPIGetInfoBeforeMakeOrder       @"m=ApiImeiReceipt&a=gobuy"    //下单时，获取用户信息，主要是收货地址（登录与无登陆）
//#define kAPIWriteOrder                 @"m=ApiImeiOrder&a=doorder" //提交订单 old
#define kAPIWriteOrder                   @"m=ApiImeiOrder&a=addorder_v3" //提交订单 new

#define kAPIWriteGiftCouponOrder         @"m=ApiImeiOrder&a=add_gift_order" //提交礼品券订单

#define kAPIGetOrderDetail               @"m=ApiImeiOrder&a=detail"

#define kAPIBeforeWriteOrder             @"m=ApiImeiOrder&a=goto_settlement_check" //填写订单前购物车中验证
#define kAPIGetWeixinPayParams           @"m=ApiImeiOrder&a=wxpay_go_buy" //微信支付获取微信支付参数
/**
 *  商品 商店
 */
#define kAPIGetGoodDetail             @"m=Apicust&a=goodsshow" //获取商品详情
#define kAPIGetGoodCommentList        @"m=ApiReviewTwo&a=revgoodslist"
#define kAPIGetSHopCommentList        @"m=Apicust&a=review"


/*
 *
 */
#define kAPIOrderList                 @"m=ApiImeiOrder&a=orderlist_v3"  //订单列表(外卖)
#define kAPIDiscountOrderList         @"m=ApiImeiOrder&a=order_sale_list"  //订单列表(优惠maidan)
/*
 * 评论
 */

#define kAPICommentOrder              @"m=Apicust&a=orderedit_v2"      //确认收货
#define kAPICommentGood               @"m=ApiReviewTwo&a=reviewadd"
#define kAPICommentShop               @"m=Apicust&a=reviewa_shops_h5" //评价接口

#define kAPIDiscountBill              @"m=ApiImeiOrder&a=addorder_sale_v3"  //优惠买单，提交订单

#define kAPIDiscountBillOrderDetail              @"m=ApiImeiOrder&a=order_sale_detail"  //优惠买单，订单详情

#define kAPIDiscountBillWeixinPayResult          @"m=ApiImeiOrder&a=see_order_pay"

/*
 * 购物车
 */

#define kAPIGetCart                   @"m=ApiImeiUsers&a=get_my_cart_list_v2"   //获取购物车列表数据
#define kAPIAddOrUpdateCartGood       @"m=ApiImeiUsers&a=add_update_cart_v2"  //商品列表添加商品或者更新
#define kAPIAddCartGood               @"m=ApiImeiUsers&a=add_goods_num_cart"  //商品列表添加商品或者更新

#define kAPIReduceCartGood            @"m=ApiImeiUsers&a=cut_goods_num_cart_v2"   //减少商品
#define kAPIDeleteCartGood            @"m=ApiImeiUsers&a=delete_goods_cart"//删除商品
#define kAPIUpdateGoodInfo            @"m=ApiImeiUsers&a=over_cart"  //提交订单修改商品信息

#define kAPIValidateTimeOutPay        @"m=ApiImeiOrder&a=rcbpayment_v2" //验证是否是45分钟之类支付

#define kAPIClearShopCart             @"m=ApiImeiUsers&a=delete_shops_cart" //清空购物车

/**
 *  获取早餐列表
 */

#define kAPIBreakFast                 @"m=ApiSubGoods&a=get_sub_goods_list"   //获取早餐列表

#define kAPIBreakPreOrder             @"m=ApiSubGoods&a=add_shoping_cart"   //获取早餐购物车

#define kAPITakePlacePoint            @"m=ApiSubGoods&a=get_goods_take_place" //获取自提点列表

#define kAPIPostBreakFastOrder      @"m=ApiSubGoods&a=add_order_v2" //提交早餐订单
//#define kAPIPostBreakFastOrder    @"m=ApiSubGoods&a=add_order" //现在线上提交早餐订单

#define kAPIPostValidateOrder       @"m=ApiSubGoods&a=sub_goods_check"  //验证提交信息

#define kAPIGetBreakFastOrderDetail @"m=ApiSubGoods&a=get_suborder_detail"

//发现列表
#define kAPIGetDiscoverList         @"m=ApiAuout&a=get_found_auout"

//代金券 活动 优惠

#define KAPICouponList              @"m=ApiCoupon&a=get_mine_coupon_list_v2"     //获取代金券列表

#define KAPICouponAdd               @"m=ApiCoupon&a=add_coupon_v2"                //添加一个代金券

#define KAPIDiscount                @"m=ApiShopTwo&a=shop_sale_detail_v3"         //优惠买单


//二维码
#define KAPIGetMyRcodeImage         @"m=ApiSweep&a=get_my_image_code"     //获取二维码图片
#define kAPIQRRecommend             @"m=ApiSweep&a=sweep_recommend"


//统计、信息记录相关

#define KAPITimeAtamps              @"m=ApiServer&a=get_server_info"             //获取系统时间戳
#define kAPIDownloadCount           @"m=ApiCount&a=channel_apk_count"

#define kAPIFindGoodsClickNum       @"m=ApiShare&a=find_goods_third_num"  //发现商品分享统计


//本地路径
/*
 *
 */

//banner url
#define ADSURLPATH [NSString stringWithFormat:@"%@%@%@",NSHomeDirectory(),@"/Documents",@"/adsUrl.plist"]
//banner id
#define ADSIDPATH [NSString stringWithFormat:@"%@%@%@",NSHomeDirectory(),@"/Documents",@"/adsId.plist"]

//以前的8大分类
#define CATEGORYTYPE [NSString stringWithFormat:@"%@%@%@",NSHomeDirectory(),@"/Documents",@"/category.plist"]

//首页展示的店铺的条件
#define SHOPSORTPATH [NSString stringWithFormat:@"%@%@%@",NSHomeDirectory(),@"/Documents",@"/shopSort.plist"]

//活动
#define ACTIVEPATH [NSString stringWithFormat:@"%@%@%@",NSHomeDirectory(),@"/Documents",@"/homeActive.plist"]

//首页店铺
#define ADDSHOPPATH [NSString stringWithFormat:@"%@%@%@",NSHomeDirectory(),@"/Documents",@"/adsShop.plist"]

#define CommenConfigPath [NSString stringWithFormat:@"%@%@%@",NSHomeDirectory(),@"/Documents",@"/commenConfig.plist"]

//保存上一次支付方式
#define PAYMENTPATH [NSString stringWithFormat:@"%@%@%@",NSHomeDirectory(),@"/Documents",@"/payment.plist"]

//保存本机上登录用户信息
#define User_Upload_Location_Info [NSString stringWithFormat:@"%@%@%@",NSHomeDirectory(),@"/Documents",@"/user_location.plist"]

// 常用枚举

typedef enum{
    
    MessageInfoViewControllerTypeGuanfang,//官方消息
    MessageInfoViewControllerTypeOrder,//订单
    MessageInfoViewControllerTypeGongxiao,//供销
    
}MessageInfoViewControllerType;



#endif /* APIUrl_h */
