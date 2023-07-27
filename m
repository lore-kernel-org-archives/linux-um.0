Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6A5EB64DD
	for <linux-um@archiver.kernel.org>; Thu, 27 Jul 2023 06:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q+QDlMchyqK29kU2ODyrTJ2XbE1HUczKS79SRqjwnQ8=; b=v0j2ps6/hgpgR0
	Qe/4E7duRAPm/cUTXlzWce3hi7sdOu4s5DOZcgBFG56627SMpKxsx4eCYNg6hcZz6VZGbl0xeNLra
	YSrQSJvrqeM3ZnINcuARleS2vU6KjmB/rMNQqZ+1xl33yb9AcCWsg3tVGj+mxknNGJjTHJHdvaF9h
	/0jD5z0PiTB/AfK82oYJcwIipo4WJCGj49umJ3W9lPz7AbwVr1Uw2MQ42Wynm3ZZ5pqu+gxiVlAaP
	2WotZC/P6OUquOAv8VDgMEHoAdHMe8OT2v1g/Ox0V2m4InOUij/ka3Nix4QPvZXRS9s5i/reW6BPu
	gVzvPMuD2fpOcR9RnlLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOu3T-00CHCJ-25;
	Thu, 27 Jul 2023 06:00:55 +0000
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qOu3R-00CHBi-1c;
	Thu, 27 Jul 2023 06:00:53 +0000
Message-ID: <16a13cab-6974-e2a6-f4c5-45971ede258b@infradead.org>
Date: Wed, 26 Jul 2023 23:00:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: Tree for Jul 27 (fbdev/core/fbcon.o)
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-um <linux-um@lists.infradead.org>, linux-fbdev@vger.kernel.org
References: <20230727143346.079d4e5a@canb.auug.org.au>
 <4c1ba872-156a-68d4-4d2f-ef459a8b7997@infradead.org>
In-Reply-To: <4c1ba872-156a-68d4-4d2f-ef459a8b7997@infradead.org>
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 7/26/23 22:56, Randy Dunlap wrote:
> 
> 
> On 7/26/23 21:33, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20230726:
>>
> 
> on ARCH=um, SUBARCH=i386:
> 
> many build errors for fbdev:
> 
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `store_rotate_all':
> UM32/../drivers/video/fbdev/core/fbcon.c:3205: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `store_rotate':
> UM32/../drivers/video/fbdev/core/fbcon.c:3183: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `show_cursor_blink':
> UM32/../drivers/video/fbdev/core/fbcon.c:3245: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `show_rotate':
> UM32/../drivers/video/fbdev/core/fbcon.c:3225: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_modechange_possible':
> UM32/../drivers/video/fbdev/core/fbcon.c:2766: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `get_color':
> UM32/../drivers/video/fbdev/core/fbcon.c:287: undefined reference to `console_blanked'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_palette':
> UM32/../drivers/video/fbdev/core/fbcon.c:2571: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_modechanged':
> UM32/../drivers/video/fbdev/core/fbcon.c:2678: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2686: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2692: undefined reference to `vc_resize'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2702: undefined reference to `color_table'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2703: undefined reference to `redraw_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_all_vcs':
> UM32/../drivers/video/fbdev/core/fbcon.c:2718: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2723: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2735: undefined reference to `vc_resize'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_debug_enter':
> UM32/../drivers/video/fbdev/core/fbcon.c:2253: undefined reference to `color_table'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_resize':
> UM32/../drivers/video/fbdev/core/fbcon.c:2048: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_disp':
> UM32/../drivers/video/fbdev/core/fbcon.c:1347: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1391: undefined reference to `vc_resize'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1393: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1394: undefined reference to `redraw_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_deinit':
> UM32/../drivers/video/fbdev/core/fbcon.c:1190: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1202: undefined reference to `con_is_bound'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `do_fbcon_takeover':
> UM32/../drivers/video/fbdev/core/fbcon.c:530: undefined reference to `do_take_over_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_do_set_font':
> UM32/../drivers/video/fbdev/core/fbcon.c:2430: undefined reference to `vc_resize'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2433: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2436: undefined reference to `redraw_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_def_font':
> UM32/../drivers/video/fbdev/core/fbcon.c:2544: undefined reference to `get_default_font'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2546: undefined reference to `find_font'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_font':
> UM32/../drivers/video/fbdev/core/fbcon.c:2522: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_prepare_logo':
> UM32/../drivers/video/fbdev/core/fbcon.c:612: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:614: undefined reference to `redraw_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_init':
> UM32/../drivers/video/fbdev/core/fbcon.c:1022: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1025: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1039: undefined reference to `find_font'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1040: undefined reference to `get_default_font'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1091: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1123: undefined reference to `vc_resize'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1133: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fb_flashcursor':
> UM32/../drivers/video/fbdev/core/fbcon.c:368: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:370: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `store_cursor_blink':
> UM32/../drivers/video/fbdev/core/fbcon.c:3271: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_switch':
> UM32/../drivers/video/fbdev/core/fbcon.c:2072: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2171: undefined reference to `color_table'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2176: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2178: undefined reference to `update_region'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_blank':
> UM32/../drivers/video/fbdev/core/fbcon.c:2232: undefined reference to `redraw_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_startup':
> UM32/../drivers/video/fbdev/core/fbcon.c:923: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:924: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:962: undefined reference to `find_font'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:963: undefined reference to `get_default_font'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:977: undefined reference to `vc_resize'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `set_con2fb_map':
> UM32/../drivers/video/fbdev/core/fbcon.c:822: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:836: undefined reference to `con_is_bound'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:861: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `con2fb_init_display':
> UM32/../drivers/video/fbdev/core/fbcon.c:797: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:797: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:806: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:806: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:806: undefined reference to `redraw_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_suspended':
> UM32/../drivers/video/fbdev/core/fbcon.c:2654: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_resumed':
> UM32/../drivers/video/fbdev/core/fbcon.c:2666: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2666: undefined reference to `redraw_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_fb_unregistered':
> UM32/../drivers/video/fbdev/core/fbcon.c:2910: undefined reference to `do_unregister_con_driver'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_remap_all':
> UM32/../drivers/video/fbdev/core/fbcon.c:2930: undefined reference to `con_is_bound'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_fb_blanked':
> UM32/../drivers/video/fbdev/core/fbcon.c:3039: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3044: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3046: undefined reference to `do_blank_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3048: undefined reference to `do_unblank_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_new_modelist':
> UM32/../drivers/video/fbdev/core/fbcon.c:3065: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_get_requirement':
> UM32/../drivers/video/fbdev/core/fbcon.c:3083: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3094: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3094: undefined reference to `vc_cons'
> 
> Full randconfig file is attached.


Sorry, I missed these kconfig warnings:


WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
  Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
  Selected by [y]:
  - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]

WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
  Depends on [n]: VT [=n] && FRAMEBUFFER_CONSOLE [=y]
  Selected by [y]:
  - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && FRAMEBUFFER_CONSOLE [=y]

WARNING: unmet direct dependencies detected for FONT_8x16
  Depends on [n]: FONT_SUPPORT [=n]
  Selected by [y]:
  - FB_VT8623 [=y] && HAS_IOMEM [=y] && FB [=y] && PCI [=y] && FRAMEBUFFER_CONSOLE [=y]
  - FB_ARK [=y] && HAS_IOMEM [=y] && FB [=y] && PCI [=y] && FRAMEBUFFER_CONSOLE [=y]

WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
  Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
  Selected by [y]:
  - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]

WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
  Depends on [n]: VT [=n] && FRAMEBUFFER_CONSOLE [=y]
  Selected by [y]:
  - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && FRAMEBUFFER_CONSOLE [=y]

WARNING: unmet direct dependencies detected for FONT_8x16
  Depends on [n]: FONT_SUPPORT [=n]
  Selected by [y]:
  - FB_VT8623 [=y] && HAS_IOMEM [=y] && FB [=y] && PCI [=y] && FRAMEBUFFER_CONSOLE [=y]
  - FB_ARK [=y] && HAS_IOMEM [=y] && FB [=y] && PCI [=y] && FRAMEBUFFER_CONSOLE [=y]

WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
  Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
  Selected by [y]:
  - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]

WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
  Depends on [n]: VT [=n] && FRAMEBUFFER_CONSOLE [=y]
  Selected by [y]:
  - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && FRAMEBUFFER_CONSOLE [=y]

WARNING: unmet direct dependencies detected for FONT_8x16
  Depends on [n]: FONT_SUPPORT [=n]
  Selected by [y]:
  - FB_VT8623 [=y] && HAS_IOMEM [=y] && FB [=y] && PCI [=y] && FRAMEBUFFER_CONSOLE [=y]
  - FB_ARK [=y] && HAS_IOMEM [=y] && FB [=y] && PCI [=y] && FRAMEBUFFER_CONSOLE [=y]


-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
