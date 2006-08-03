Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 3 Aug 2006 14:26:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060803182612.GA4606@ccure.user-mode-linux.org>
References: <3A30AD378ECC6F41A4AC64F18E8B3F7F6E0E40@ala-mail04.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3A30AD378ECC6F41A4AC64F18E8B3F7F6E0E40@ala-mail04.corp.ad.wrs.com>
Subject: Re: [uml-devel] [uml-user] Promiscuous mode interface bug?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "Stephens, Allan" <allan.stephens@windriver.com>
Cc: Paolo Giarrusso <blaisorblade@yahoo.it>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Thu, Aug 03, 2006 at 09:29:51AM -0700, Stephens, Allan wrote:
> These differences may make sense to people who understand how the
> various transport mechanisms work, but it still leave me with a
> question: why, in the latter two cases, is UML allowing non-promiscuous
> interfaces to receive traffic that wasn't sent to them?  I can
> understand that configuring uml_switch as a hub means that packets may
> be forwarded to places they don't need to go, but shouldn't these
> packets still be filtered out somewhere further down the line?  As I
> naive user, I'm not expecting a (simulated) interface to receive traffic
> that wasn't addressed to it unless it has been explicitly configured as
> promiscuous.

Either you or I have a very basic misunderstanding of how these things
are supposed to work.  

You seem to be thinking that when you set an interface promiscuous, it
somehow reaches out to the switch and tells it to start sending it
everything, and when it is set non-promiscuous, it tells the switch to
only send stuff addressed to it.

I seem to be thinking that the packets that actually reach the
interface is not controlled by its promiscuous setting, and the
setting controls whether the packets reach the network stack and are
visible to software.

Needless to say, I think my thinking is closer to the truth.  There is
no mechanism that I know of for an interface to communicate its
promiscuous setting to a switch.  Switches do remember the MAC
associated with a port, but that is done by sniffing the packets going
by.

				Jeff

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
