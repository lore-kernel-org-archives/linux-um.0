Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CL5tP-0002Vp-V5 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 13:20:07 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CL5tN-0002az-Cv
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 13:20:07 -0700
Subject: Re: [uml-devel] [patches] ptrace fix, x11 fb update, minor stuff.
References: <20041022184126.GA9104@bytesex>
	<Pine.GSO.4.61.0410222117070.11567@waterleaf.sonytel.be>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <Pine.GSO.4.61.0410222117070.11567@waterleaf.sonytel.be>
Message-ID: <87r7nq8qq2.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: 22 Oct 2004 22:04:05 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> > X11 doesn't run yet, the X-Server wants IOPL access for some obscure
> > reason, it shouldn't need that when running on top of a framebuffer
> > device.  Anyone has an idea on that?
> 
> Ugh, that's probably a hardcoded dependency on __i386__ somewhere...

The google hits I had on that suggest that as well :-/

> Try the good old XF86_FBDev from XFree86 3.x? :-)

I would, but don't have a copy any more.  Ha, that was fun, first days
of vesafb, my good old machine being busy for many hours building
xfree86, and the X-Servers name was XF68_FBDev ;)

  Gerd

-- 
return -ENOSIG;


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
