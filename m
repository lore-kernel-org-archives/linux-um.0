Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060324023029.GD8104@ccure.user-mode-linux.org>
References: <dvv6ir$ajn$1@sea.gmane.org>
	<20060323235044.GA7273@ccure.user-mode-linux.org>
	<20060324004052.GA1897@knob.reflex>
	<200603240156.36646.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603240156.36646.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: (implementation idea) Re: uml and nonstandard memory
	splits?
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
Date: Thu, 23 Mar 2006 21:30:29 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-user@lists.sourceforge.net, Jason Lunz <lunz@falooley.org>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Mar 24, 2006 at 01:56:32AM +0100, Blaisorblade wrote:
> I don't think it's easy - however, it can be done. Below my idea - Jeff, 
> please comment on this
> 
> In assembly.
> It goes like this:
> 
> call label /*this is coded like a relative jump, i.e. call +1*/
> label: pop $eax /*we got the saved EIP*/
> 
> /* Now we can round EIP and subtract an offset to calculate the data page 
> location.
> */

How does this give us the location of the data page?

You really want to know the end of the process address space, which
you can do by taking the address of a convenient local and rounding up
to the nearest 1G or .5G or so.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
