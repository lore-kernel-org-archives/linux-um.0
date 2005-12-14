Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EmVeJ-0002mA-CD for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Dec 2005 04:22:23 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EmVeH-0001Ns-RZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Dec 2005 04:22:23 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: tls: set_thread_area failed
References: <1134008028.32598.52.camel@localhost.localdomain>
	<87fyowsjkg.fsf@amaterasu.srvr.nix> <439F8C0A.2000302@upb.de>
In-Reply-To: <439F8C0A.2000302@upb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200512141321.49910.blaisorblade@yahoo.it>
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
Date: Wed, 14 Dec 2005 13:21:48 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>, Rob Landley <rob@landley.net>, Antoine Martin <antoine@nagafix.co.uk>

On Wednesday 14 December 2005 04:05, Sven K=F6hler wrote:
> > e2fsprogs-1.38/misc/fsck.c:check_all() repeatedly invokes fsck_device(),
> > which invokes execute(), which does a perfectly normal fork()/exec().
> > No threads here. Nor is there use of aio_*(), which might use threads
> > (well, POSIX allows it).
>
> Sorry, and what's the conclusion?
>
> fork() calles set_thread_area()?

Interesting... yep, it could.

Ok, picture down:

a) in NPTL, getpid() caches the result of the syscall in the TLS - so each =
new=20
process at startup (i.e. after exec!) calls set_thread_area(). But that's=20
normal.

b) I know that in clone()*, and I presume that in fork(), the pid cache mus=
t=20
be invalidated / updated. So while fork() maybe doesn't use set_thread_area=
=20
(and it could, seeing that no TLS setup has been done, and retrying) it wan=
ts=20
to puzzle with the TLS content.

* We know that as glibc once didn't and UML was the one user of clone() +=20
getpid(), and we discovered the hard way that glibc forgot that. Workaround=
ed=20
with a real getpid().

At bug report time we got an angry Ulrich saying "it's already fixed in lat=
est=20
version", luckily.
--=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	=09
___________________________________=20
Yahoo! Messenger: chiamate gratuite in tutto il mondo=20
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_idv37&alloc_id=16865&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
