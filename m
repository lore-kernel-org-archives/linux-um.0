Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9qa9-0003dd-8J for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 12:18:01 -0800
Received: from prgy-npn1.prodigy.com ([207.115.54.37] helo=oddball.prodigy.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D9qa8-0001jr-NQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 12:18:01 -0800
Message-ID: <4231FE29.7090109@tmr.com>
From: Bill Davidsen <davidsen@tmr.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 3/9] UML - "Hardware" random number generator
References: <200503100215.j2A2FuDN015227@ccure.user-mode-linux.org><200503100215.j2A2FuDN015227@ccure.user-mode-linux.org>
	<200503101341.37346.rob@landley.net>
In-Reply-To: <200503101341.37346.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Fri, 11 Mar 2005 15:23:05 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Wednesday 09 March 2005 09:15 pm, Jeff Dike wrote:
> 
>>This implements a hardware random number generator for UML which attaches
>>itself to the host's /dev/random.
> 
> 
> Direct use of /dev/random always makes me nervous.  I've had a recurring 
> problem with /dev/random blocking, and generally configure as much as 
> possible to use /dev/urandom instead.  It's really easy for a normal user to 
> drain the /dev/random entropy pool on a server (at least one that doesn't 
> have a sound card you can tell it to read white noise from).  cat /dev/random 
> 
>>/dev/null
> 
> 
> I like /dev/urandom because it'll feed you as much entropy as it's got, but 
> won't block, and will presumably round-robin insert real entropy in the 
> streams that multiple users get from /dev/urandom.  (I realize this may not 
> be the best place to get gpg keys from.)
> 
> I'm just thinking about those UML hosting farms, with several UML instances 
> per machine, on machines which haven't got a keyboard attached constantly 
> feeding entropy into the pool.  If just ONE of them is serving ssl 
> connections from its own /dev/urandom, that would drain the /dev/random 
> entropy pool on the host machine almost immediately...
> 
> Admittedly if UML used /dev/urandom instead of /dev/random, it wouldn't know 
> how much "real" randomness it was getting and how much synthetic randomness, 
> but this makes predicting the numbers it's producing easier how?

Use of a "hardware" RNG patch without a real hardware RNG could do all 
that. I would add a caution to the help warning of this problem if you 
lack real hardware RNG capability. The really paranoid could insist that 
at least one hardware driver be configured, but how much do you need to 
protect people from themselves?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
