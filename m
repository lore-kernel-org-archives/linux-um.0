Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1flmFP-0007cW-Sc
 for linux-um@lists.infradead.org; Sat, 04 Aug 2018 02:24:54 +0000
Received: from mail-ua0-f172.google.com (mail-ua0-f172.google.com
 [209.85.217.172]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id w742O7Mb019282
 for <linux-um@lists.infradead.org>; Sat, 4 Aug 2018 11:24:07 +0900
Received: by mail-ua0-f172.google.com with SMTP id c12-v6so6480211uan.3
 for <linux-um@lists.infradead.org>; Fri, 03 Aug 2018 19:24:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <861c26a6-294c-755d-2396-e5d18b9bbcbf@infradead.org>
References: <be4f41de-c27a-abac-4b23-369c400e016e@infradead.org>
 <861c26a6-294c-755d-2396-e5d18b9bbcbf@infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 4 Aug 2018 11:23:26 +0900
Message-ID: <CAK7LNARdoeKCNYV7Kp6YLNsJ4rjrjXRWMsf4op58-JzRYUNVtg@mail.gmail.com>
Subject: Re: kbuild: ARCH=um archheaders failed
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>

2018-08-04 0:41 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 08/02/2018 05:13 PM, Randy Dunlap wrote:
>> Hi Yamada-san,
>>
>> I see this every few weeks.  It's not reproducible (it depends
>> on the moon, Mars, etc.).
>>
>> I'm using O=builddir.  The build log is short (below).
>>
>> Do you see a makefile problem here?  (nothing to do with mmotm;
>> I see it more frequently with linux-next since I do many daily
>> builds with it)
>
> BTW, this is just um defconfig with -j4.
>
> --
> ~Randy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



I will send a patch with commit description later
after more testing,
but the following patch should fix the issue.


diff --git a/arch/um/Makefile b/arch/um/Makefile
index d3975e7..1cec053 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -120,7 +120,7 @@ archheaders:
        $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
                    kbuild-file=$(HOST_DIR)/include/uapi/asm/Kbuild \
                    obj=$(HOST_DIR)/include/generated/uapi/asm
-       $(Q)$(MAKE) KBUILD_SRC= ARCH=$(HEADER_ARCH) archheaders
+       $(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) archheaders


 archprepare: include/generated/user_constants.h



-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

