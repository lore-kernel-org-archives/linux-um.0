Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ9u2-0000TC-HJ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 11:37:42 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CQ9u1-0007HJ-Ga for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 11:37:42 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Fighting latency
References: <20041104155015.GA29182@gandalf.intern.marcant.net>
	<200411050044.59629.blaisorblade_spam@yahoo.it>
	<418AEB71.1090005@vgertech.com>
In-Reply-To: <418AEB71.1090005@vgertech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411052038.15491.blaisorblade_spam@yahoo.it>
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
Date: Fri, 5 Nov 2004 20:38:15 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nuno Silva <nuno.silva@vgertech.com>, nils toedtmann <user-mode-linux-devel@nils.toedtmann.net>

On Friday 05 November 2004 03:54, Nuno Silva wrote:
> Blaisorblade wrote:
>
> ...
>
> > A fix was proposed a while ago, which consisted in mlock()ing the memory.
> > But Jeff Dike refused it because he said "I want to write a much more
> > complex and more optimal solution. Mlock() is an hack".
Actually he said something much more complex than that. You can find his 
worries in this email.

> Maybe having the linux binary in a ramfs will work better?
Wise idea! But you forgot the UML "RAM" from $TMPDIR.

Ramfs data are not swappable, so using that both for the UML binary and for * 
$TMPDIR * should work.

However, Jeff wouldn't have a different opinion on this, but it can be done 
without patching UML.

In fact, he worries about the host going OutOfMemory or anyway actually 
needing hard to swap out memory; this could even happen when, for instance, 
UML is using all memory just for caching (and maybe caching unused data). In 
the meanwhile, while one UML caches an use-only-once file, the host goes 
OutOfMemory and kills one UML instance. He wanted the UMLs to release memory 
to the host when needed.

This, however, is not a problem for dedicated UML hosting if you don't 
oversell UML ram.

> You can also do some creative mount --bind, to mount only one ramfs
> instance, if you have many UMLs running.

Not needed I think - use different names for UML binaries as needed. It will 
pickup a good name for the RAM file.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
