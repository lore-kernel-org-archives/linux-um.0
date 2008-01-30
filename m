Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Wed, 30 Jan 2008 17:37:06 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080130223706.GA15818@c2.user-mode-linux.org>
References: <47A0E650.6090705@club-internet.fr>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47A0E650.6090705@club-internet.fr>
Subject: Re: [uml-devel] uml and firefox
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: clowncoder <vincent-perrier@club-internet.fr>
Cc: User-mode-linux-user@lists.sourceforge.net, User-mode-linux-devel@lists.sourceforge.net

On Wed, Jan 30, 2008 at 10:04:16PM +0100, clowncoder wrote:
> I get a strange behaviour as far as isolation is concerned between an 
> uml machine
> and the host, my uml machine is isolated from any network,
> if firefox is already running in the host, running firefox in the uml 
> machine creates
> an instance of firefox that is not isolated: the browser can browse the net.
> if firefox is not already running in the host, then the firefox in the 
> uml reacts normaly,
> that is, it cannot get to the network.
> What can be the cause of this or did I dream it?

Firefox has this odd behavior that if you run it, and it sees there is
already a firefox instance running on that dispay *even if it is
running on a different system*, it will send a message to the existing
firefox asking it to open up a new window.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
