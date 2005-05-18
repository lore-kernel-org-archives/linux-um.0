Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYOlJ-00026j-DW	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 06:39:01 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DYOlG-0006gz-81	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 06:39:01 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Explaination of system call function flow in TT mode
Message-ID: <20050518133331.GB3925@ccure.user-mode-linux.org>
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
	<200505162324.37749.blaisorblade@yahoo.it>
	<3524bf1f0505161709476c4940@mail.gmail.com>
	<200505170217.23138.blaisorblade@yahoo.it>
	<3524bf1f050517105676c6c051@mail.gmail.com>
	<20050517220053.GA10144@ccure.user-mode-linux.org>
	<428B0F2B.3060503@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428B0F2B.3060503@fujitsu-siemens.com>
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
Date: Wed, 18 May 2005 09:33:31 -0400
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Young Koh <young.koh@gmail.com>, Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Wed, May 18, 2005 at 11:47:23AM +0200, Bodo Stroesser wrote:
> I also thought about not saving FP-regs on each kernel entry. But if you do
> this optimization, you need to save / restore FP-regs on switch_to. Also you
> need to get the FP-regs when setting up a signal-handler stackframe. And 
> they
> have to be restored on sys_(rt_)sigreturn from the values found in the
> stackframe.

True, but these are much less frequent than kernel entries/exits.

> I hope, I didn't miss some other places that would need adaption.

Offhand, this sounds right.

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
