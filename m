Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHA7d-0007qN-Kt for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:02:33 -0700
Received: from nudl.linbit.com ([212.69.162.21] helo=mail.linbit.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CHA72-0004AU-83 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:02:33 -0700
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
Subject: Re: [uml-devel] SOLVED: uml "ip header error" for large (fragmented)
	udp packets
Message-ID: <xneXIovOv53ZtptO+AU2uyI=lge@web.de>
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<vm4cST3zEEx6OdPLK17ocyg=lge@web.de>
	<20041006203539.GC22794@wotan.suse.de>
	<200410072041.51890.blaisorblade_spam@yahoo.it>
	<RO4HJxErhAMlOpdbW1UCZm8=lge@web.de>
	<j7l8RdbM+9uLzg0PWMggkBg=lge@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j7l8RdbM+9uLzg0PWMggkBg=lge@web.de>
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
Date: Tue, 12 Oct 2004 02:03:03 +0200
To: user-mode-linux-devel@lists.sourceforge.net

/ 2004-10-11 19:55:12 +0200
\ Lars Ellenberg:
> since UML => Host does not work, but
> Host => UML does, this suggests that
> the bug is somewhere on the sending side.
> 
> I was not able to track it down.

just so you know, finally:

=======================
--- linux-2.6.6/arch/um/include/sysdep-i386/checksum.h.orig	2004-10-12 01:50:49.000000000 +0200
+++ linux-2.6.6/arch/um/include/sysdep-i386/checksum.h	2004-10-12 01:50:58.000000000 +0200
@@ -102,8 +102,7 @@
 	   are modified, we must also specify them as outputs, or gcc
 	   will assume they contain their original values. */
 	: "=r" (sum), "=r" (iph), "=r" (ihl)
-	: "1" (iph), "2" (ihl)
-	: "memory");
+	: "1" (iph), "2" (ihl));
 	return(sum);
 }
 
=======================

that's all, folks. only a missing memory barrier.

WTF :-/

same patch applies to 2.6.8.1 - uml and probably all other umls.
since that is a one-to-one copy anyways, maybe UML should better use the
original (in include/asm-i386/checksum.h) right away??
there may be similar bugs hiding in various areas of uml...

Thanks for now,
keep it going...

btw,
anyone wants to give me a hint how to tune it best?
maybe how to up the mtu of the UML "nics"?

	Lars Ellenberg

"NLRge your UML-UDP" ...


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
