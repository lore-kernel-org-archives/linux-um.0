Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6DCM-0003LA-Pa for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Mar 2005 11:38:26 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D6DCJ-0001Uq-RB for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Mar 2005 11:38:26 -0800
Message-Id: <200503012137.j21LagMY009262@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] 2.6.10 command line longer than 512 characters 
In-Reply-To: Your message of "Fri, 07 Jan 2005 11:12:42 +0100."
	<Pine.LNX.4.58.0501071105351.22595@cube.iu.hio.no> 
References: <Pine.LNX.4.58.0501071105351.22595@cube.iu.hio.no> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 01 Mar 2005 16:36:42 -0500
To: Kyrre M Begnum <Kyrre.Begnum@iu.hio.no>
Cc: user-mode-linux-devel@lists.sourceforge.net

Kyrre.Begnum@iu.hio.no said:
> I have noticed that when I supply a command line longer than 513
> characters (or was it 512?) the kernel crashes. Output supplied at the
> end of mail. This does not seem to be a problem on the old 2.4.24
> guest kernels. Is there a way I can change this, perhaps during kernel
> configuration? 

This is fixed in my long-command-line patch.

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
