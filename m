Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8OAe-0004tM-Q3 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:45:40 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D8OAc-0006GH-TP for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:45:40 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Partial fix! - Was: Re: [BUG report] UML
	linux-2.6 latest BK doesn't compile
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
	<1108380903.22656.9.camel@imp.csi.cam.ac.uk>
	<200503051945.j25JjIB5003539@ccure.user-mode-linux.org>
In-Reply-To: <200503051945.j25JjIB5003539@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503072044.49206.blaisorblade@yahoo.it>
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
Date: Mon, 7 Mar 2005 20:44:48 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>, lkml <linux-kernel@vger.kernel.org>

On Saturday 05 March 2005 20:45, Jeff Dike wrote:
> aia21@cam.ac.uk said:
> > Yes.  I finally found a way to get it to compile.  Compiling without
> > TT mode and WITHOUT static build it still fails with the same problem
> > (__bb_init_func problem I already reported).  But compiling without TT
> > but WITH static build the __bb_init_func problem goes away but instead
> > I get a __gcov_init missing symbol in my modules.
> >
> > Note I have gcc-3.3.4-11 (SuSE 9.2) and it defines __gcov_init.  So I
> > added this as an export symbol and lo and behold the kernel and
> > modules compiled and I am now up an running with UML and NTFS as a
> > module.  (-:
>
> Can you try this patch?  It exports either __gcov_init or __bb_init_func
> depending on your gcc version.
a) wrong because you say __GNUC_PATCHLEVEL__ > 4 rather than >=
b) wrong because for he the link failed on __bb_init_func at the beginning. So 
in the case you need to export BOTH symbols.

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
