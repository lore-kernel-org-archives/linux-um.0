Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmWio-0000HB-Dl for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jul 2004 04:54:18 -0700
Received: from vs1.mcgroarty.net ([69.44.158.141] helo=mcg.mcgroarty.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.34) id 1BmWio-0000ed-41
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jul 2004 04:54:18 -0700
Subject: Re: [uml-devel] [Bug#260111: user-mode-linux: upgrade hangs at "NET4:
	Linux TCP/IP 1.0 for NET4.0"]
Message-ID: <20040719115417.GA5505@mcgroarty.net>
References: <20040718184513.GP4090@mizar.alcor.net>
	<20040719000403.GA23215@stateless>
	<20040719002409.GA4456@mcgroarty.net>
	<20040719021321.GB23215@stateless>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719021321.GB23215@stateless>
From: Brian McGroarty <brian@mcgroarty.net>
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
Date: Mon, 19 Jul 2004 06:54:17 -0500
To: Nicholas Lee <nj.lee@plumtree.co.nz>
Cc: Matt Zimmerman <mdz@debian.org>, user-mode-linux-devel@lists.sourceforge.net, 260111-forwarded@bugs.debian.org

On Mon, Jul 19, 2004 at 02:13:21PM +1200, Nicholas Lee wrote:
> 
> Well this is odd.
> 
> [...]
> 
> So 2.4.25 works, and 2.4.26 requires tee to work.

Yes, that was the case for me. However, tee only prolonged the life of
the machine.

With tee, I can bring up the machine in single-user mode if I use tee,
but attempting to boot fully results in a hang when exim4 is coming
up. Attempting to go to multi-user mode from single user mode results
in a hang when inetd is coming up.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
