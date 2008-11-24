Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rmy@tigress.co.uk>) id 1L4Xf1-0004v6-Dw
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Nov 2008 09:23:15 +0000
Received: from mail.tigress.co.uk ([195.172.168.163] helo=intgat.tigress.co.uk)
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L4Xew-0003fw-Pt
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Nov 2008 09:23:15 +0000
From: Ron Yorston <rmy@tigress.co.uk>
Message-Id: <200811240922.mAO9Mbxg020777@tiffany.internal.tigress.co.uk>
Date: Mon, 24 Nov 2008 09:22:36 +0000
References: <200811231729.mANHT1uE020562@tiffany.internal.tigress.co.uk>
	<1227484743.11944.19.camel@cloonix>
In-Reply-To: <1227484743.11944.19.camel@cloonix>
MIME-Version: 1.0
Subject: Re: [uml-devel] A shared memory framebuffer for UML
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
To: vincent-perrier@club-internet.fr, rmy@tigress.co.uk
Cc: user-mode-linux-devel@lists.sourceforge.net

root <vincent-perrier@club-internet.fr> wrote:
>Now my question: would this framebuffer help in the video part
>of the sip communication? Could the sip application transmit
>images to the host's display? Could the sip application receive
>from a real webcam?

I don't think so, at least not as I understand what you're trying to
do.

The framebuffer is like giving UML a graphics card:  the guest can
display a console on it or run an X server on it.  It will let you see
X applications on the guest, but there are already ways to do that.
(Run an Xvnc server on the guest, or ssh into it and export an
application's display back to your local X server.)  And it won't help
at all with importing webcam images into the guest, that's an entirely
different problem.

Ron

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
