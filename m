Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYQr8-0000P7-IR	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 08:53:10 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DYQr5-0006CZ-Ts	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 08:53:10 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Explaination of system call function flow in TT mode
Message-ID: <20050518150946.GC18740@ccure.user-mode-linux.org>
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
	<428B0F2B.3060503@fujitsu-siemens.com>
	<3524bf1f050518062432e093d6@mail.gmail.com>
	<200505181657.49102.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505181657.49102.blaisorblade@yahoo.it>
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
Date: Wed, 18 May 2005 11:09:46 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Wed, May 18, 2005 at 04:57:47PM +0200, Blaisorblade wrote:
> In this case, instead, for SKAS mode, we must switch the registers manually, 
> since we have collapsed everything in one host process. For TT and SKAS0 
> mode, instead, it's not needed, right Jeff and Bodo?

Correct.

	Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
