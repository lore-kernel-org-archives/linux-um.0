Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADTLe-000073-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 25 Oct 2003 11:41:14 -0700
Received: from brown.brainfood.com ([146.82.138.61] helo=gradall.private.brainfood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ADTI8-00029q-7C
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 25 Oct 2003 11:37:36 -0700
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] uml_switch
In-Reply-To: <Pine.LNX.4.21.0310251039390.21477-100000@ucontrol.mobiledns.com>
Message-ID: <Pine.LNX.4.44.0310251336340.16509-100000@gradall.private.brainfood.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 25 Oct 2003 13:37:07 -0500 (CDT)
To: steven james <pyro@linuxlabs.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, 25 Oct 2003, steven james wrote:

> Greetings,
>
> Of course, UML itself 'just happens' to use the configured IP address
> (mildly mangled) as the MAC address for IP traffic.

Not for my setup.  I set the mac address of my umls on the cmdline, they talk
to a uml switch, which also happens to be configured to forward to the host.
My umls then use dhcp to get their address.



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
