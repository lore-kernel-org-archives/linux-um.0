Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IvWBO-0004A3-A8 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Nov 2007 02:54:50 -0800
Received: from el-out-1112.google.com ([209.85.162.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IvWBK-0006NZ-Lf
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Nov 2007 02:54:50 -0800
Received: by el-out-1112.google.com with SMTP id y26so1235925ele
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 23 Nov 2007 02:54:45 -0800 (PST)
Message-ID: <4746B171.1070001@gmail.com>
Date: Fri, 23 Nov 2007 11:54:41 +0100
From: Jiri Olsa <olsajiri@gmail.com>
MIME-Version: 1.0
References: <E1Is5FL-00078H-00@dorka.pomaz.szeredi.hu>	<20071114011002.GA11477@c2.user-mode-linux.org>	<E1IsFbA-0007y2-00@dorka.pomaz.szeredi.hu>	<20071114142247.GA5848@c2.user-mode-linux.org>	<E1IsK83-0008CJ-00@dorka.pomaz.szeredi.hu>	<20071114173639.GA7899@c2.user-mode-linux.org>	<E1IsPo5-0008RU-00@dorka.pomaz.szeredi.hu>	<20071116170630.GA9299@c2.user-mode-linux.org>	<E1IvGTn-0007cC-7q@dorka.pomaz.szeredi.hu>	<20071122235141.GA7876@c2.user-mode-linux.org>
	<ea9232d10711230101j24e4bd4btce65e62b9fcc8f8b@mail.gmail.com>
In-Reply-To: <ea9232d10711230101j24e4bd4btce65e62b9fcc8f8b@mail.gmail.com>
Subject: Re: [uml-devel] uml doesn't work on 2.6.24-rc2
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Karol Swietlicki <magotari@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Miklos Szeredi <miklos@szeredi.hu>

Hi,

after applying following changes, the mainline is working for me.

Jiri Olsa


diff --git a/arch/um/Kconfig.i386 b/arch/um/Kconfig.i386
index e0ac74e..234fcb4 100644
--- a/arch/um/Kconfig.i386
+++ b/arch/um/Kconfig.i386
@@ -8,6 +8,13 @@ config UML_X86
 	bool
 	default y
 
+config X86_32
+	bool
+	default y
+
+config RWSEM_XCHGADD_ALGORITHM
+	def_bool y
+
 config 64BIT
 	bool
 	default n
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 31999bc..ba6813a 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -168,7 +168,7 @@ ifneq ($(KBUILD_SRC),)
 	$(Q)mkdir -p $(objtree)/include/asm-um
 	$(Q)ln -fsn $(srctree)/include/asm-$(HEADER_ARCH) include/asm-um/arch
 else
-	$(Q)cd $(TOPDIR)/include/asm-um && ln -fsn ../asm-$(SUBARCH) arch
+	$(Q)cd $(TOPDIR)/include/asm-um && ln -fsn ../asm-$(HEADER_ARCH) arch
 endif
 
 $(objtree)/$(ARCH_DIR)/include:

Karol Swietlicki wrote:
> On 23/11/2007, Jeff Dike <jdike@addtoit.com> wrote:
>> On Thu, Nov 22, 2007 at 07:08:47PM +0100, Miklos Szeredi wrote:
>>> Thanks.  My other problem is (probably you are aware) that recent -mm
>>> kernels don't compile for UML.
>> The patch below fixes the build for rc3-mm1 for me.
>>
>>                                 Jeff
> 
> There must be something more to it. I got a clean -mm and it still
> does not build after applying the patch. It does have less problems,
> but it still won't build. I tried to get it to compile for half an
> hour, but considering the amount of sleep I got (and my experience),
> there is no surprise that I failed miserably. After fixing the
> complaint about a structure not having a 'x86' member, it died in the
> linker complaining about stuff relating to rwsem.h.
> 
> Karol Swietlicki
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
