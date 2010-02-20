Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1NirK1-0005mL-Q6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Feb 2010 15:32:45 +0000
Received: from mail-yx0-f200.google.com ([209.85.210.200])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NirK0-0003nm-6F for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Feb 2010 15:32:45 +0000
Received: by yxe38 with SMTP id 38so1060688yxe.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 20 Feb 2010 07:32:38 -0800 (PST)
Date: Sat, 20 Feb 2010 23:35:21 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20100220153521.GK3000@hack>
References: <20100220143359.GD3000@hack>
	<20100220150936.GP30031@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100220150936.GP30031@ZenIV.linux.org.uk>
Subject: Re: [uml-devel] [Patch] um: tell git to ignore generated files
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Am??rico Wang <xiyou.wangcong@gmail.com>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Sat, Feb 20, 2010 at 03:09:36PM +0000, Al Viro wrote:
>On Sat, Feb 20, 2010 at 10:33:59PM +0800, Am??rico Wang wrote:
>> 
>> git should ignore these files, since they are generated.
>
>> +include/shared/kern_constants.h
>> +include/shared/user_constants.h
>
>I have patches taking that to include/generated, actually

Oh, ok, I can remove these two for you. :)

Thanks.


------------>

Tell git to ignore the generated files under um, except:

include/shared/kern_constants.h
include/shared/user_constants.h

which will be moved to include/generated.

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>


---
diff --git a/.gitignore b/.gitignore
index de6344e..efab0eb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -36,6 +36,7 @@ modules.builtin
 #
 tags
 TAGS
+linux
 vmlinux
 vmlinuz
 System.map
diff --git a/arch/um/.gitignore b/arch/um/.gitignore
new file mode 100644
index 0000000..f22bd73
--- /dev/null
+++ b/arch/um/.gitignore
@@ -0,0 +1,3 @@
+kernel/config.c
+kernel/config.tmp
+kernel/vmlinux.lds


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

