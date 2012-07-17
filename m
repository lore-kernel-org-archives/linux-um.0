Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tytso@thunk.org>) id 1SrFnX-0003iZ-Iq
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jul 2012 21:59:15 +0000
Received: from li9-11.members.linode.com ([67.18.176.11] helo=imap.thunk.org)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps
	(TLSv1:AES256-SHA:256) (Exim 4.76) id 1SrFnV-0006uB-1W
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jul 2012 21:59:15 +0000
Date: Tue, 17 Jul 2012 17:29:46 -0400
From: Theodore Ts'o <tytso@mit.edu>
Message-ID: <20120717212946.GE6049@thunk.org>
References: <4FFDA698.2000707@landley.net> <20120713030325.GB12245@thunk.org>
	<50032B11.7070505@landley.net> <20120716152140.GA27656@thunk.org>
	<50059EAA.9080000@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50059EAA.9080000@landley.net>
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
To: Rob Landley <rob@landley.net>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

On Tue, Jul 17, 2012 at 12:19:38PM -0500, Rob Landley wrote:
> That should be over on _this_ list then...
> 
> (Discussion of IRQF_SAMPLE_RANDOM removal.)

I took a closer look at the arch/um code, and it wasn't as hard as I
thought.  I have a proposed set of patches to completely remove
IRQF_SAMPLE_RANDOM that I will be sending out shortly....

		   	       	  	      - Ted

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

