Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1SrGHN-0007lc-AE
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jul 2012 22:30:05 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SrGHL-00010r-Ub
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jul 2012 22:30:05 +0000
Date: Wed, 18 Jul 2012 00:29:51 +0200
From: Richard Weinberger <richard@nod.at>
Message-ID: <20120718002951.366b16ab@spider.haslach.nod.at>
In-Reply-To: <20120717212946.GE6049@thunk.org>
References: <4FFDA698.2000707@landley.net> <20120713030325.GB12245@thunk.org>
	<50032B11.7070505@landley.net> <20120716152140.GA27656@thunk.org>
	<50059EAA.9080000@landley.net> <20120717212946.GE6049@thunk.org>
Mime-Version: 1.0
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
Subject: Re: [uml-devel] feature-removal-schedule entry from 2009
To: Theodore Ts'o <tytso@mit.edu>, user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com, Rob Landley <rob@landley.net>

Am Tue, 17 Jul 2012 17:29:46 -0400
schrieb Theodore Ts'o <tytso@mit.edu>:

> On Tue, Jul 17, 2012 at 12:19:38PM -0500, Rob Landley wrote:
> > That should be over on _this_ list then...
> > 
> > (Discussion of IRQF_SAMPLE_RANDOM removal.)
> 
> I took a closer look at the arch/um code, and it wasn't as hard as I
> thought.  I have a proposed set of patches to completely remove
> IRQF_SAMPLE_RANDOM that I will be sending out shortly....
> 

I'll happily test them, please CC me.

BTW: On UML we have anyway CONFIG_UML_RANDOM to get good random numbers.
It reads from thes host's /dev/random.

Thanks,
//richard

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

