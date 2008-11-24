Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rmy@tigress.co.uk>) id 1L4Ykg-0002No-2d
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Nov 2008 10:33:10 +0000
Received: from mail.tigress.co.uk ([195.172.168.163] helo=intgat.tigress.co.uk)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L4Ykb-0006ux-9o
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Nov 2008 10:33:09 +0000
Received: (from uucp@localhost)
	by intgat.tigress.co.uk (8.13.1/8.13.1) id mAOAX2gM005793
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 24 Nov 2008 10:33:02 GMT
From: Ron Yorston <rmy@tigress.co.uk>
Message-Id: <200811241032.mAOAWjd4020866@tiffany.internal.tigress.co.uk>
Date: Mon, 24 Nov 2008 10:32:45 +0000
References: <200811231729.mANHT1uE020562@tiffany.internal.tigress.co.uk>
In-Reply-To: <200811231729.mANHT1uE020562@tiffany.internal.tigress.co.uk>
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
To: user-mode-linux-devel@lists.sourceforge.net, rmy@tigress.co.uk

I was in too much of a hurry yesterday and didn't include some useful
information about shmfb clients.

To make use of the framebuffer the client needs to know its details.
It also needs to be able to send keyboard and mouse events to the guest
and to receive information about updates to the guest's display.

When a UML kernel uses a shared memory framebuffer it creates the file
~/<name>/shmid.  This contains the id of the shared memory segment and
the dimensions of the display (width, height and depth).

It also sets up a socket to enable communication between host and
guest.  This is based on the way mconsole works, but with a much
simplified protocol that's tailored to the needs of the framebuffer.
The host sends information about keyboard and mouse events to the
guest.  It can also request information from the guest as to which
areas of the framebuffer have been updated.

This latter point is something of a limitation:  the client has to poll
for updates.  Furthermore, there's nothing to prevent more than one
client from connecting to the same guest.  The guest doesn't keep track
of its clients separately, so the clients won't be informed about all
updates.  A workaround for that would be to have the clients just
update the whole display, whether or not anything has changed.  But
that's inefficient.  A proper fix for these issues is to have the
kernel track client connections and send updates without prompting.

The rate at which the clients update their displays can be controlled
with the --fps option, which sets the number of frames per second.  The
default is 10fps.

The X client requires the MIT-SHM extension in the host X server.  The
format of the framebuffer memory must match that of a shared memory
image in the host X server.  So if you have a 16-bit display you need
to specify a framebuffer depth of 2 bytes per pixel to use the X
client.

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
