Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzCUE-0002Bb-KO for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 03:27:54 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CzCUB-000320-03 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 03:27:54 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] strace of "ls" under Fedora Core 3
References: <A06801158AE07847B27A52C1A074BC1D0725A4D6@fmsmsx404.amr.corp.intel.com>
In-Reply-To: <A06801158AE07847B27A52C1A074BC1D0725A4D6@fmsmsx404.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502101226.47978.blaisorblade@yahoo.it>
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
Date: Thu, 10 Feb 2005 12:26:47 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Wichmann, Mats D" <mats.d.wichmann@intel.com>, Marion Bates <mbates@whoopis.com>, William Stearns <wstearns@pobox.com>

On Wednesday 09 February 2005 21:12, Wichmann, Mats D wrote:
> > As a quick reminder, Marion and Bill are trying to get
> >i386 fedora
> >core 3 running under uml (2.6.4, with the i386 emulation code) on ford
> >(x86_64).

Well, the problem is that UML for x86_64 is not yet complete, especially for 
the 32-bit compatibility code, as stated by Jeff. This is what creates you 
those problems.

You should absolutely run a 32-bit UML if you want good support for 32-bit 
programs.

To compile it, either you set up well the compilation environment for 32-bit 
programs or you build the binary on a 32-bit host distro.

> >The uml binaries don't have TLS support, so we've renamed 
> >all of: /lib/tls. /usr/lib/tls, and /usr/X11R6/lib/tls directories.
> > Even with that done, we're getting "cannot set up LDT
> >for thread-local
> >storage" as an error message when running something as simple as
> >/bin/ls.  It appears that there's TLS system calls in the binary
> >itself, not just in the */lib/tls libraries:
>
> I'm not sure this call is a TLS thing.
I can add that it is *not* a TLS thing absolutely for sure...

Also, the code inside UML should absolutely support it (from the code I don't 
see any problem), at least for the x86 UML.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
