Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfKBU-0000Ce-KU	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 09:10:40 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DfKBQ-00041L-GT	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 09:10:40 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Problem running SMP-UML (both skas & tt)
References: <OF2C0F2572.688466F1-ON65257018.00480279-65257018.0048CBFD@in.ibm.com>
In-Reply-To: <OF2C0F2572.688466F1-ON65257018.00480279-65257018.0048CBFD@in.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uYHpC4ypSNfQofx"
Message-Id: <200506061813.34693.blaisorblade@yahoo.it>
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
Date: Mon, 6 Jun 2005 18:13:34 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sriram Raghunathan <sraghuna@in.ibm.com>, user-mode-linux-user@lists.sourceforge.net

--Boundary-00=_uYHpC4ypSNfQofx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 06 June 2005 15:26, Sriram Raghunathan wrote:
> Hi,
>   We're having problems running UML with SMP enabled...(ie ncpus>1) on Suse
> Linux 9.0 with
> 2.6.5-7.97-smp (host kernel)

> We've built UML with linux-2.6.11.7 & have been unsuccessful running linux
> in either skas nor tt modes
> for SMP.
Well, for SKAS mode there is no support yet... for TT mode the support used to 
work until recently, but is not very used because SKAS mode is usually 
faster, so it's less debugged than it should be...
> Of-course, we have absolutely no problems when we're in single cpu 
> mode with npcus=1.

> Here I would need to mention that when we enable debug, we get the
> following error message during
> linking stage:
> kernel/profile.c:387: undefined reference to `profile_pc".

> We went ahead & commented this out to get the build to work..would
> appreciate if somebody could point
>  us to a patch. However this is not the crux of the problem we're facing.
The fixlet for this is attached... Sadly I cannot help for now on the bigger 
picture, but I'll have a look on it.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_uYHpC4ypSNfQofx
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-add-profile-pc-i386.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-add-profile-pc-i386.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---


diff -puN include/asm-um/ptrace-i386.h~uml-add-profile-pc-i386 include/asm-um/ptrace-i386.h
--- clean-linux-2.6.11/include/asm-um/ptrace-i386.h~uml-add-profile-pc-i386	2005-06-06 17:57:23.000000000 +0200
+++ clean-linux-2.6.11-paolo/include/asm-um/ptrace-i386.h	2005-06-06 17:57:24.000000000 +0200
@@ -30,6 +30,10 @@
 #define PT_REGS_SYSCALL_RET(r) PT_REGS_EAX(r)
 #define PT_FIX_EXEC_STACK(sp) do ; while(0)
 
+/* Cope with a conditional i386 definition. */
+#undef profile_pc
+#define profile_pc(regs) PT_REGS_IP(regs)
+
 #define user_mode(r) UPT_IS_USER(&(r)->regs)
 
 #endif
_

--Boundary-00=_uYHpC4ypSNfQofx--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
