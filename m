Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBZ99-0000KH-6L for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 06:00:43 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BBZ98-0004W0-Kt
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 06:00:42 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040408130134.GA7655@bytesex.org>
References: <200404080207.i3827rbe009294@ccure.user-mode-linux.org>
	<87smfevfq2.fsf@bytesex.org>
	<200404081249.i38CnsB6002514@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404081249.i38CnsB6002514@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: A quick humfs HOWTO
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
Date: Thu, 8 Apr 2004 15:01:34 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Apr 08, 2004 at 08:49:54AM -0400, Jeff Dike wrote:
> kraxel@bytesex.org said:
> > Hmm.  Why separate?  These days almost all filesystems in 2.6 support
> > extended attributes, that would be the ideal place for such metadata
> > IMHO ... 
> 
> On 2.4, too?  People are going to be running 2.4 for a while.

Vanilla kernels not.  But patches are available and distro kernels often
have that patched in because samba already uses them for quite some time.
ACLs are also stored in EAs.

  Gerd

-- 
http://bigendian.bytesex.org


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
