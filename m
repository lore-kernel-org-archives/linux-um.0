Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9ah7-0000Qs-Vq for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Mar 2005 19:20:09 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D9ah6-00033G-DC
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Mar 2005 19:20:09 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [PATCH 3/9] UML - "Hardware" random number generator
References: <200503100215.j2A2FuDN015227@ccure.user-mode-linux.org>
In-Reply-To: <200503100215.j2A2FuDN015227@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503101341.37346.rob@landley.net>
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
Date: Thu, 10 Mar 2005 13:41:37 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org

On Wednesday 09 March 2005 09:15 pm, Jeff Dike wrote:
> This implements a hardware random number generator for UML which attaches
> itself to the host's /dev/random.

Direct use of /dev/random always makes me nervous.  I've had a recurring 
problem with /dev/random blocking, and generally configure as much as 
possible to use /dev/urandom instead.  It's really easy for a normal user to 
drain the /dev/random entropy pool on a server (at least one that doesn't 
have a sound card you can tell it to read white noise from).  cat /dev/random 
> /dev/null

I like /dev/urandom because it'll feed you as much entropy as it's got, but 
won't block, and will presumably round-robin insert real entropy in the 
streams that multiple users get from /dev/urandom.  (I realize this may not 
be the best place to get gpg keys from.)

I'm just thinking about those UML hosting farms, with several UML instances 
per machine, on machines which haven't got a keyboard attached constantly 
feeding entropy into the pool.  If just ONE of them is serving ssl 
connections from its own /dev/urandom, that would drain the /dev/random 
entropy pool on the host machine almost immediately...

Admittedly if UML used /dev/urandom instead of /dev/random, it wouldn't know 
how much "real" randomness it was getting and how much synthetic randomness, 
but this makes predicting the numbers it's producing easier how?

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
