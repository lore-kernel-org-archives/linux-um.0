Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrWiE-0004br-21 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 23:26:38 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CrWiC-0000J8-Gr
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 23:26:37 -0800
Received: from knoppix (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.12.11/8.12.11) with ESMTP id j0K8ZT5D013059
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 20 Jan 2005 03:35:30 -0500
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] UML build process uses perl? (With sed alternative.)
References: <200501140040.56592.rob@landley.net>
	<200501191955.55131.blaisorblade@yahoo.it>
In-Reply-To: <200501191955.55131.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8607Bxoy6HPHa31"
Message-Id: <200501200125.01522.rob@landley.net>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 20 Jan 2005 01:25:00 -0500
To: user-mode-linux-devel@lists.sourceforge.net


--Boundary-00=_8607Bxoy6HPHa31
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 19 January 2005 01:55 pm, Blaisorblade wrote:

> Please double-check that the patch works with your busybox sed
> implementation, and compare the original and the new obtained config.c
> carefully, since the sed code you supplied wasn't good.

I've double checked, and it worked fine.

I still need the attached one-liner patch to get it to build under uclibc, 
though.

Thanks,

Rob

--Boundary-00=_8607Bxoy6HPHa31
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="strlcpy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="strlcpy.patch"

--- linux-2.6.9-old/arch/um/include/user.h	2005-01-20 00:38:43.000000000 -0500
+++ linux-2.6.9/arch/um/include/user.h	2005-01-20 00:39:00.000000000 -0500
@@ -14,7 +14,6 @@
 extern void kfree(void *ptr);
 extern int in_aton(char *str);
 extern int open_gdb_chan(void);
-extern int strlcpy(char *, const char *, int);
 extern void *um_vmalloc(int size);
 extern void vfree(void *ptr);
 

--Boundary-00=_8607Bxoy6HPHa31--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
