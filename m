Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQATl-0005Sr-1w for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 12:42:21 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQATk-0000Sj-GW for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 12:42:20 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] CVS not updated?
In-Reply-To: <20040518180259.GC29114@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0405182131440.10300-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 18 May 2004 21:42:13 +0200 (CEST)
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 18 May 2004, Jeff Dike wrote:

> That's because I haven't figured out how to do that.  I have a little passwd
> file that looks right to me, I've checked everything else I can think of,
> and it still doesn't work.

From the error message I think you are missing a "anonymous" system user
or a suitable mapping in your CVS password file to another suitable system 
user..

The CVS password file format is

login:[password][:unixuser]

if the unixuser is not specified the login is used..

Example for anonymous CVS with pubcvs as the UNIX user

  anonymous::pubcvs

> If you can offer clues, I will gratefully accept.  If you (or anyone else who
> knows about CVS) want a login so you can figure out what's wrong, let me 
> know.

I can offer to login to try to fix the problem if the above does not help.  
My SSH keys can be found at http://marasystems.com/people/hno/,
http://www.squid-cache.org/~hno/ or
http://hem.passagen.se/hno/Welcome.html

> Yeah, I moved it off of SF, as part of my effort to move away from there
> and become self-hosting.

I was on the edge to move my projects from SF about 6 months ago due to
the numerous CVS issues, but they have managed to restore the quality of
their service and today the only reason I see to not use SF for my 
projects is if I were to use another revision control system such as 
arch or subversion.. but at the moment I find CVS works very well for my 
purposes..

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
