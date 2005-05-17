Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXzoB-00045R-TA	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 04:00:19 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DXzoA-0005m4-5s
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 04:00:19 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: uml-general-protection-fault even more kludgy but
	mergeable
Message-ID: <20050517105934.GD20584@bytesex>
References: <200505170005.43629.blaisorblade@yahoo.it>
	<20050517100317.GB20584@bytesex> <4289C66C.9000709@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4289C66C.9000709@fujitsu-siemens.com>
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
Date: Tue, 17 May 2005 12:59:34 +0200
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

> >The case I trapped into was an attempt to access I/O ports of a
> >process running inside the uml.  The uml kernel then tried to
> >handle that as page fault, which didn't work very well ...

> Unfortunately, I can't find the previous mails about this. So, maybe I'm
> totally wrong. If so, please discard this mail.

Yes, was discussed quite some time ago, more than half a year
IIRC.

> Gerd, did you see the problem in SKAS3 on i386? If so, it would be nice to
> see what happens in SKAS0.

Not tested yet.

> I saw similar problems regarding bad LDT-descriptors. Processes using a bad
> descriptor loop on page_fault.
> 
> The real fix for this is to add trap_no to the info, that is read from host
> by PTRACE_FAULTINFO. With this info, UML can distinguish between real page
> faults and other SIGSEGVs.

Yes, that conclusion we came to as well, the real fix would be
pass on trap_no.  The patch mentioned in $subject is a band-aid
fix to deal with it a bit better without having the trap number.

> In SKAS0, UML already has the full info, as it retrieves the info from a
> sigcontext.

Then skas0 should do fine in theory ;)

  Gerd

-- 
-mm seems unusually stable at present.
	-- akpm about 2.6.12-rc3-mm3


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
