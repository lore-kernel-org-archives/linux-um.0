Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8iDU-0007Ge-TW for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 09:09:56 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D8iDU-0001Tn-C2
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 09:09:56 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [BUG: UML 2.6.11-rc4-bk-latest] sleeping function
	called from invalid context and segmentation fault
References: <1108381733.10703.5.camel@imp.csi.cam.ac.uk>
	<200502222141.54891.blaisorblade@yahoo.it>
	<200503051907.41787.blaisorblade@yahoo.it>
In-Reply-To: <200503051907.41787.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200503081107.11787.rob@landley.net>
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
Date: Tue, 8 Mar 2005 11:07:11 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>

On Saturday 05 March 2005 01:07 pm, Blaisorblade wrote:
> That said, there must be something else going on... it is easy to get the
> "repeated chars" problem (cat a file is enough), which I thought linked to
> this: it's when some data is printed and re-printed many times...
>
> , and everybody started noticing it just around 2.6.9 / 2.6.10. I'm not
> sure, but maybe something else is causing the problem...

Speaking of which, if it'sthe same repeated characters problem I saw I've been 
meaning to look into that (since I can reproduce it easily), but I just 
haven't had time due to day-jobness.

I wsa under the vague impression that we were doing a write() into a pipe 
somewhere that was doing a partial write and returning, and the retry code 
wasn't skipping the already written bit when it retried the write.  (Could be 
wrong, but it matches the behavior I saw.  If the xterm it's writing into 
can't take data for a bit because the system's gone all swap happy, that's 
when I see the repeats...)

Dunno if this is the problem you've been seeing...

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
