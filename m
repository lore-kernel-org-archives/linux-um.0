Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DIPoY-0007kf-QE for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Apr 2005 04:32:18 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DIPoX-0004xd-9a for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Apr 2005 04:32:18 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] question about UML sigcontext in tt mode
Message-ID: <20050404140011.GA1977@ccure.user-mode-linux.org>
References: <003501c535d8$e8574a50$90b3c68a@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003501c535d8$e8574a50$90b3c68a@st.com>
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
Date: Mon, 4 Apr 2005 10:00:11 -0400
To: Alex LIU <alex.liu@st.com>
Cc: UML-dev <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Mar 31, 2005 at 06:03:34PM +0800, Alex LIU wrote:
> union uml_pt_regs {
> #ifdef UML_CONFIG_MODE_TT
> 	struct tt_regs {
> 		long syscall;
> 		void *sc;
> 	} tt;
> #endif
> };
> -------------------------------------
> 
> Then why the tt.sc is defined as void while not as struct sigcontext? Thanks!

Probably because you can't get a definition of struct sigcontext into 
processor.h and have it still compile.

Try #including sigcontext.h there and you'll see what I mean.

				Jeff


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
