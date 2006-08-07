Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GACQM-0008Eb-HW for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Aug 2006 14:14:10 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GACQK-0007m3-0X
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Aug 2006 14:14:10 -0700
Date: Mon, 7 Aug 2006 17:13:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060807211352.GA5890@ccure.user-mode-linux.org>
References: <20060806154431.32159.74360.stgit@memento.home.lan>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060806154431.32159.74360.stgit@memento.home.lan>
Subject: Re: [uml-devel] [PATCH] [RFC] uml: make activate_fd atomic
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
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Aug 06, 2006 at 05:44:31PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> I had this patch in my queue since some time, because it fixes some spinlocks vs
> sleeps issues; please verify whether after your restructuring it is still
> needed (it applied before this restructuring).

I believe this patch is no longer needed.  It looks like all calls to
activate_fd are in process context.  However, there are a few places
where it can be reached inside a spinlock.  These cases look like the
spinlock is held for too long, and needs to be narrowed.

Here's my work, if you feel like checking it.  Increasing indendation
is going up the call chain.  At the top of each chain, there's a
"proc", along with my reason for believing the procedure is only
called in process context.  When that's not there, it's because that
call tree had already been covered ealier.

There's some stuff in the network which I didn't go into because it's
code I have no clue about.

Every procedure can call activate_fd under a spinlock is so marked.

activate_fd can recurse to itself, but only once.  This happens when
the first descriptor needing sigio coverage is activated.  The sigio
thread will be started, a pipe to it created, and an irq registered
for that pipe.

activate_fd
    um_request_irq
        line_setup_irq
	    enable_chan
		line_open - SPINLOCK
		    ssl_open, con_open - tty_operations.open
			tty_open - proc, in response to open(2)
	register_winch_irq
	    register_winch
		chan_enable_winch
		    line_open
	    is_tracer_winch, is_skas_winch
		register_winch
	mconsole_fuse - proc, work_proc
	mconsole_init - proc, initcall
	uml_net_open - struct net_device.open, SPINLOCK
	    dev_open
		dev_change_flags - ?
		ipmr_new_tunnel - ?
		ipmr_reg_vif - ?
	port_accept
	    port_work_proc - proc, work_proc
	port_data
	    port_init - chan_ops.init
		parse_chan
		    parse_chan_pair
			line_config
			lines_init
			    ssl_config, con_config
				line_driver.mc.config - mconsole_devices
				    mconsole_config - proc, work_proc
	xterm_fd
	    xterm_open
		chan_ops.open
		    open_one_chan
			open_chan
			    console_open_chan
				ssl_console_setup, uml_console_setup - struct console.setup
				    register_console
					mc_add_console - proc, initcall
					ssl_init - proc, initcall
					stderr_console_init - proc, initcall
					stdio_init - proc, initcall
	x11_probe
	    x11_init - proc, initcall
	init_aio_irq
	    init_aio - proc, initcall
	write_sigio_irq
	    write_sigio_workaround - SPINLOCK
		maybe_sigio_broken
		    activate_fd

				Jeff

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
