Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADPkd-0004iZ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 25 Oct 2003 07:50:47 -0700
Received: from ucontrol.mobiledns.com ([216.162.33.29])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ADPck-0001A2-6w
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 25 Oct 2003 07:42:38 -0700
Received: from ucontrol.mobiledns.com (localhost [127.0.0.1])
	by ucontrol.mobiledns.com (8.12.3/8.12.3) with ESMTP id h9PEgYmK008494
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 25 Oct 2003 10:42:35 -0400
Received: from localhost (pyro@localhost)
	by ucontrol.mobiledns.com (8.12.3/8.12.3/Debian-6.4) with ESMTP id h9PEgOs6008486
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 25 Oct 2003 10:42:34 -0400
From: steven james <pyro@linuxlabs.com>
Subject: Re: [uml-devel] uml_switch
In-Reply-To: <20031023181144.GU1538@dijkstra.csh.rit.edu>
Message-ID: <Pine.LNX.4.21.0310251039390.21477-100000@ucontrol.mobiledns.com>
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
Date: Sat, 25 Oct 2003 10:42:23 -0400 (EDT)
Cc: user-mode-linux-devel@lists.sourceforge.net

Greetings,

Of course, UML itself 'just happens' to use the configured IP address
(mildly mangled) as the MAC address for IP traffic.

However, it would be best to add functionality to parse the packet
headers. Definatly NOT wanted for normal use due to efficiency
issues. Perhaps a config option? compile time?

G'day,
sjames



On Thu, 23 Oct 2003, Matt Zimmerman wrote:

> On Thu, Oct 23, 2003 at 07:55:24AM -0300, Nelio Pereira wrote:
> 
> > I would like to know where in the uml_switch code is the best place to do
> > that. Actually, I'd like to intercept those messages in a place where I
> > could know the sender and recipient IP of each message.
> 
> I haven't checked the code, but I don't think that uml_switch decodes the IP
> header at all; it only deals with Ethernet frames.
> 
> 

-- 
-------------------------steven james, director of research, linux labs
... ........ ..... ....                    230 peachtree st nw ste 2701
the original linux labs                             atlanta.ga.us 30303
      -since 1995                              http://www.linuxlabs.com
                                   office 404.577.7747 fax 404.577.7743
-----------------------------------------------------------------------





-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
