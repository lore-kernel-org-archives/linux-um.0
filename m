Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DEHrN-0008Q6-EH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 18:14:09 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DEHrJ-0000L4-ON for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 18:14:09 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [patch 05/12] uml: extend cmd line limits
References: <s2401e0e.085@ORANGE.OUS.EDU>
In-Reply-To: <s2401e0e.085@ORANGE.OUS.EDU>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hHiQCMmT07snGp5"
Message-Id: <200503240311.45515.blaisorblade@yahoo.it>
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
Date: Thu, 24 Mar 2005 03:11:45 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anthony Brock <Anthony_Brock@ous.edu>

--Boundary-00=_hHiQCMmT07snGp5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 22 March 2005 22:30, Anthony Brock wrote:
> Blaisor,
>
> Perhaps the error message should be changed from:
>
> "add_arg: Too much command line!\n"
>
> to something like:
>
> "add_arg: Too many command line arguments!\n"
>
> Does this explain the error more clearly? Or am I mistaken?
Yes, I was copying it and didn't notice the message didn't make sense.

Here is the patch, it's queued and will be sent shortly.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_hHiQCMmT07snGp5
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-correct-message.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-correct-message.patch"


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, "Anthony Brock" <Anthony_Brock@ous.edu>

Replace the message with a more meaningful one. Noted by Anthony Brock.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/um_arch.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/um_arch.c~uml-correct-message arch/um/kernel/um_arch.c
--- linux-2.6.11/arch/um/kernel/um_arch.c~uml-correct-message	2005-03-24 03:04:59.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/um_arch.c	2005-03-24 03:05:36.000000000 +0100
@@ -47,7 +47,7 @@ char command_line[COMMAND_LINE_SIZE] = {
 void add_arg(char *arg)
 {
 	if (strlen(command_line) + strlen(arg) + 1 > COMMAND_LINE_SIZE) {
-		printf("add_arg: Too much command line!\n");
+		printf("add_arg: Too many command line arguments!\n");
 		exit(1);
 	}
 	if(strlen(command_line) > 0)
_

--Boundary-00=_hHiQCMmT07snGp5--




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
