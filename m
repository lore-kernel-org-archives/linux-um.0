Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DH0qY-0005dF-GB for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Mar 2005 06:40:34 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DH0qX-0008Gg-Et
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Mar 2005 06:40:34 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [uml-devel] Re: [patch 03/12] uml: export getgid for hostfs
Message-ID: <20050331144026.GA18248@infradead.org>
References: <20050322162123.890086BA6F@zion>
	<200503240302.29153.blaisorblade@yahoo.it>
	<20050329114529.GA26005@infradead.org>
	<200503302005.26311.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503302005.26311.blaisorblade@yahoo.it>
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
Date: Thu, 31 Mar 2005 15:40:26 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 08:05:26PM +0200, Blaisorblade wrote:
> > My unaswered reply to the first submission is at
> >
> > http://groups-beta.google.com/group/linux.kernel/messages/de9504fe5963ccd1,
> >0c05294c599b22b1,eab26a4ed3f8ff17?thread_id=16c905c7e28e7498&mode=thread&noh
> >eader=1&q=uml-export-getgid-for-hostfs#doc_eab26a4ed3f8ff17
> >
> > (sorry, couldn't find it on marc), it's been Cc'ed to the lists you sent
> > the patch to.
> Sorry, I wasn't clear... I read *that* answer, but it says "as mentioned in 
> the discussion about ROOT_DEV", and I couldn't find it.

That'd be:

http://marc.theaimsgroup.com/?l=linux-fsdevel&m=110664428918937&w=2

> Also, I'd like to know whether there's a correct way to implement this (using 
> something different than root_dev, for instance the init[1] root directory 
> mount device). I understand that with the possibility for multiple mounts the 
> "root device" is more difficult to know (and maybe this is the reason for 
> which ROOT_DEV is bogus, is this?), but at least a check on the param 
> "rootfstype=hostfs" could be done.

personally I think it's a bad misfeature by itself.  If you absolutely
want it make it a mount option so it's explicit at least.

And yes, the only place where ROOT_DEV makes sense is in the early boot
process where the first filesystem in the first namespace is mounted, that's
why I want to get rid of the export to modules for it.

> Ok, this is nice. I'll repost the (updated) patch CC'ing Ingo Molnar (unless 
> there's another Ingo).

Yupp, mingo



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
