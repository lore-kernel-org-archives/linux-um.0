Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4mrw-0003kH-M1 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 13:47:12 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C4mrv-0004WW-52
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 13:47:12 -0700
Message-Id: <200409072149.i87LnQBP010747@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Mon, 30 Aug 2004 21:40:15 +0200."
	<200408302140.15460.blaisorblade_spam@yahoo.it> 
References: <200408302140.15460.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: UML merge in after 2.6.8.1 - what to do now
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
Date: Tue, 07 Sep 2004 17:49:26 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> Now, how will we work? I have some ideas about this, which I'd like to
> discuss  with everybody here. I think that the UML patch will become
> the "development  tree" of UML, where new patches hang around to get
> some testing, while the  mainline kernel should get only safe patches.
> For instance, for now the humfs  and filehandle work must *not* go in
> mainline, since they are highly  experimental.

Yeah, this sounds reasonable.  My tree will be experimental stuff, and 
forwarded to Andrew/Linus when it is considered OK.  

> Also, the various uml patch should never be actually "merged" inside
> the UML  patch: it must always be a patchset, i.e. a collection of
> separate patches.  Like -mm. So merging with mainline will be easier,
> as reviewing separate  patches or dropping bad ones.

Yup.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
