Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
References: <20040615113816.02b911c5.schpoo@dartmouth.edu>
	<87zn73biui.fsf@amaterasu.srvr.nix>
	<25d101c453c1$9978f090$2000000a@schlepptopp>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <25d101c453c1$9978f090$2000000a@schlepptopp> (roland's message
	of "Wed, 16 Jun 2004 18:47:17 +0200")
Message-ID: <87oenjb1vo.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: [BUG!?] Re: [uml-user] TUNSETIFF failed, errno =
	16SIOCSIFFLAGS: Device or resource busy
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
Date: Wed, 16 Jun 2004 22:59:23 +0100
To: roland <for_spam@gmx.de>
Cc: Naomi Fox <schpoo@Dartmouth.EDU>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Wed, 16 Jun 2004, roland stipulated:
> hi!
> 
>> > When I start up my UML, the networking works fine.  If I bring down my
>> > interface and attempt to bring it back up again, I get the following
>> > message.
>> >
>> > # ifconfig eth0 down
>> > # ifconfig eth0 up
>> > TUNSETIFF failed, errno = 16SIOCSIFFLAGS: Device or resource busy
> 
>> ... which it is: it's a component of the bridge, and doesn't have its
>> own independent existence anymore.
> 
> yes - and that is why we should somewhat call it a "bug" - because a
> uml user indeed is allowed to bring down/up eth0, but he (usually)
> isn't allowed to do something outside the uml.

This is just the analogue of the way in which taking a link down from
one end will automatically take it down at the other end, too.

>> Either bring down br0, or bring down the UML side of the link.
>> that is a workaround , not a solution.
> i think UML needs some fix to handle tun/tap via bridge appropriately.

Er, it works now. :)

-- 
`We in no way believe that this Christ was a space alien.'
                    --- A creationist website goes completely bonkers


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
