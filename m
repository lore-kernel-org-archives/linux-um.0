Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACHBp-0003j0-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 22 Oct 2003 04:30:09 -0700
Received: from ns2.todo.gr.jp ([61.197.226.214] helo=todo.gr.jp)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1ACF2j-0003le-D6
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 22 Oct 2003 02:12:37 -0700
Message-ID: <00b301c3987b$36a79ea0$26a8080a@swh.swh.nttdata.co.jp>
From: "Kunio Miyamoto" <wakatono@todo.gr.jp>
References: <200310212018.h9LKILeg002739@ccure.karaya.com> <200310212115.h9LLFneg003091@ccure.karaya.com> <20031022035215.GA4291@fieldses.org>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0-test8
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 22 Oct 2003 18:02:22 +0900
To: user-mode-linux-devel@lists.sourceforge.net


Hi.

> I downloaded the patch from the URL above; it doesn't seem to have any
> hostfs code in it.
> Applying the /fs/ parts of the -test5 patch seems to work for
> now....--Bruce Fields

 I tried by using hostfs code in uml patch for linux-2.6-test5, and it seems
to work well.

 If you try to use hostfs in linux-2.6-test8 + uml patch, apply hostfs codes of
test5 (+uml patch) and modify Makefile as below..

 add 1 line as below in Makefile in fs dir.

obj-$(CONFIG_HOSTFS)            += hostfs/

 I made patch kit ( tarball ) to linux-2.6-test8 + uml patch by Jeff Dike.

 If you use this patch kit, see below.

1. download it
 http://www.todo.gr.jp/~wakatono/hostfs-for-uml-2.6-test8+patch.tar

 It includes hostfs code and modified Makefile in [kernel_top_dir]/fs directory.

2. untar it
 cd [your_uml_kernel_top_dir]/fs
 tar xvf [downloaded file name]

3. build uml kernel.

Cheers.
---
Kunio Miyamoto
E-mail: wakatono@todo.gr.jp
WebDAV Resources JP: http://webdav.todo.gr.jp/ 



-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
