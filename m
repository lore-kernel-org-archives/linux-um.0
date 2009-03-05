Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nickpiggin@yahoo.com.au>) id 1Lf3kc-0006Hv-AU
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Mar 2009 02:55:58 +0000
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1Lf3kW-000769-AJ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Mar 2009 02:55:58 +0000
From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Thu, 5 Mar 2009 13:55:43 +1100
References: <20090304145109.GA7140@duck.suse.cz>
	<20090304155535.GA23108@duck.suse.cz>
	<20090304175031.GA24730@duck.suse.cz>
In-Reply-To: <20090304175031.GA24730@duck.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200903051355.43909.nickpiggin@yahoo.com.au>
Subject: Re: [uml-devel] fsx-linux loosing mmap() writes under memory
	pressure
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thursday 05 March 2009 04:50:31 Jan Kara wrote:
> On Wed 04-03-09 16:55:35, Jan Kara wrote:
> > On Wed 04-03-09 15:51:09, Jan Kara wrote:
> > >   first, I'd like to point out that this has happened under UML so it
> > > can be just some obscure bug in that architecture but I belive it's
> > > worth debugging anyway. Now to the problem:
> > >   This has happened with today Linus's git snapshot. The filesystem is
> > > ext3 with *1KB* blocksize. I booted UML with 64MB of memory and run
> > > (these are test's from Andrew Morton's torture tests):
> > >   fsx-linux -l 8000000 /mnt/testfile
> > >   bash-shared-mapping -t 8 /mnt/bashfile 50000000
> > > (the second test just makes the UML under memory pressure and stresses
> > > the filesystem, otherwise it does not interact with fsx-linux in any
> > > way). After some time (like an hour) fsx-linux reported the file is
> > > corrupted. I tried again and it happened again so probably some
> > > debugging should be possible.
> > >   Both times it seems we've simply completely lost a write which
> > > happened through mmap (2 pages in the first case, 3 pages in the second
> > > case). Also I've checked and in the first case no blocks are allocated
> > > for the offsets where the data should be so most probably we've lost
> > > the write before block_write_full_page() called get_block().
> > >   I'll debug this further but I wanted let people know there's some
> > > problem and maybe somebody has some bright idea :).  I'm attaching the
> > > log from fsx if someone is interested.
> >
> >   Testing a bit more, I managed to reproduce the problem on ext2 and
> > what's more strange, now the lost page was written via ordinary write()
> > (fsxlog attached). So I believe this is more likely to be UML specific...
>
>   And to add even more information, this also happens on ext2 with 4KB
> blocksize (although much more rarely it seems). Again the data was written
> by an extending write() but the block for it was not even allocated...

What block device driver are you using?

Can it be reproduced without mapped reads and writes completely? (-W -R)



------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

