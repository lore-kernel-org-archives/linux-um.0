Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQLLZ-00088C-Jh for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Apr 2005 01:23:09 -0700
Received: from ns.virtualhost.dk ([195.184.98.160] helo=virtualhost.dk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1DQLLY-0000cd-2W
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Apr 2005 01:23:09 -0700
From: Jens Axboe <axboe@suse.de>
Message-ID: <20050426082247.GB1851@suse.de>
References: <20050424181924.EAFCB55D06@zion> <20050425101625.GD1671@suse.de>
	<200504252120.15493.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504252120.15493.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [patch 7/7] uml ubd: handle readonly status
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
Date: Tue, 26 Apr 2005 10:22:48 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Apr 25 2005, Blaisorblade wrote:
> On Monday 25 April 2005 12:16, Jens Axboe wrote:
> > On Sun, Apr 24 2005, blaisorblade@yahoo.it wrote:
> > > @@ -1099,6 +1104,7 @@ static int prepare_request(struct reques
> > >  	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
> > >  		printk("Write attempted on readonly ubd device %s\n",
> > >  		       disk->disk_name);
> > > +		WARN_ON(1); /* This should be impossible now */
> > >  		end_request(req, 0);
> > >  		return(1);
> > >  	}
> >
> > I don't think that's a sound change. The WARN_ON() is strictly only
> > really useful for when you need the stack trace for something
> > interesting. As the io happens async, you will get a boring trace that
> > doesn't contain any valuable information.
> Ok, removed, and resending the patch, is the rest ok? I.e. is that
> supposed to work? I gave a walk around and it seemed that the code
> handles set_{disk,device}_ro() even during the open, but I'm no block
> layer expert.

I'd keep the checks for sanity. Although the set_disk/device_ro prevents
regular fs write mounts, a buggy layered drive could still send down a
write by accident.

-- 
Jens Axboe



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
