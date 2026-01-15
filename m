Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37606D44C7D
	for <linux-um@archiver.kernel.org>; Thu, 15 Jan 2026 16:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=URJX5xTHolO9FC46ryjpGruJ5TGEDEyfrbwATuqwgLQ=; b=jh6RaMp/pVMrtG+zX8alzbqH0f
	G9I9+QL5cgOkzPoN8lhQOR/k2nLaF8Hf12eIyzI5S9NZkUx9U/zZ+VIsqySY918VywwrU5ma8uGXa
	xuXRZgdWB6ff172g3qbHShN5HnPGffn53yux5eeclm/wEWz6PMvptpA34Q5HrMzQ3Dsk/emp7EceT
	hH3j+wqpdxackNtP6lzNO42/nHgsTV/ntz3APZ1UIpm+j+lmQpe1rdy37YCVs2CyW3G6i4DSb8APx
	rOzXQIK3Rrk1hls9oIro/KSlfoqDrkBze1Iu9A0J9Rp/q93KXK9rJ+/1V0OljVgaEXewqt+lg8cR+
	5yQoAs6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgQDN-0000000Ch2P-1325;
	Thu, 15 Jan 2026 16:28:53 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgQDK-0000000Ch12-2XqR
	for linux-um@lists.infradead.org;
	Thu, 15 Jan 2026 16:28:51 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-42fbc305914so725323f8f.0
        for <linux-um@lists.infradead.org>; Thu, 15 Jan 2026 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768494529; x=1769099329; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=URJX5xTHolO9FC46ryjpGruJ5TGEDEyfrbwATuqwgLQ=;
        b=ALZOzStXIPkGagswmZPpSJpDPHck/uP3TMJADyIj6zYsevpH+4211o+B+qmY7+G/QS
         RvfTRQ7qLds56ALcOlZOL0nV6Zfr/Gn29CMBA+GS5zVR2Su5H9Kg4Ye3lBSlGLXBbADP
         Zt2VSVSUu377b/Z3DUbCldH1rRYcGFgvCWXJtLQNWrI0sWueJnf5uW0dLPWNWqp/tsWl
         Z5t/dzY9gpkM9L1BJLJJyHXchyDk2l4QDeewjOpHAje8OAQcLMe8t7yb52bnZbBROQkH
         HTtKkPYqmjyjx7M9H0AiMBwMwdV1kHw5ySynoX0ckphR8vD0/bck7VxRJTv/OSM1Qtr3
         0Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768494529; x=1769099329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URJX5xTHolO9FC46ryjpGruJ5TGEDEyfrbwATuqwgLQ=;
        b=ZkiHxNXTc/m7OcFnNPwWxQ8Gv9vBEi9e/xFdIMAs4Y280A13Kd6CTVdbnWJR0kxeEu
         +VjenSeoQIehp0O02JGr/8iKuVQyfIntZ7azfRhB588+NxDMQFX2EOwuajCwnDthdZyf
         pwuSd15Zlu+gGpdI7RxFuLQm+JLcTXaBXmcg6K3AJ3bd1bP0IODiL8+tieORiqceiwT6
         E95KSpOnKC1j40JOLX555Lg/S3Xn+5WJSoFpwt9Wasj1I8rNuME9n3lbft+UNhZrFGkX
         QlHfQryk5Aa9q8kbTLyxloAiJTTIrO6zHbn4JBbmdyr7Kvmontrvx92Qcf/qUVpqd6Tf
         V5ew==
X-Forwarded-Encrypted: i=1; AJvYcCWYxfkrhB8ANN/43KxIVtCkCqenl+rNX4um3HCfYM535L0yngax6b4SBl13tAZeBxClQsf8CEOQ2g==@lists.infradead.org
X-Gm-Message-State: AOJu0YyccAUIg+SFvq85mEGdsuS/ojpgIsxtQVPnhwFvOKlfNGzvSlmE
	AxkBIVb/DE4NVwlcWBupR2Mtv9g462GaaAURbPbcyVRA3nN7ucyI5my0BW4eoSYIwEI=
X-Gm-Gg: AY/fxX7tEwHxkfY0uQUShtvgXFNylTTbIlI33HcimTn2v2aqB9PK4MEIONuZ4PotimG
	FRasLKmVVteZ1zOfR8RG19ksbOlhcRJzUGWViEwgPUSHVJ5oo/qvxBJNKCUTAAvmPlNXL4bqzFw
	5AHq6FSn5CHdjFxhAfM6DobbhOpyj+q7MAZnbPlyXPaNoF6dV/nTHTfKUhwWEItpEUM+sXcUeDS
	N00mx9yXii+pQqycDa7frXUcL9EI68lCQzpEc6NwAaNwIunakCbx0sy2YypbYePINwaScDNT146
	hdfu32ROcqZjSVpAWbOL47fRtFw11FZCdNCknlnhLStXcltptBWciDksxgo0oxr3C/5gccFS+L7
	R7By1Fc7JkT8mCAd7RDl0N9+HITChEVthOzJazGd0mf7ldqVWXZdTNd+/ycToXDAh8rP5YNa3hD
	wg6CAwcU/uQcswLw==
X-Received: by 2002:a5d:64c5:0:b0:430:fd0f:2910 with SMTP id ffacd0b85a97d-4342c501a57mr9777353f8f.26.1768494528600;
        Thu, 15 Jan 2026 08:28:48 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6e148bsm6604069f8f.33.2026.01.15.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 08:28:47 -0800 (PST)
Date: Thu, 15 Jan 2026 17:28:44 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/19] drivers: tty: serial: ma35d1_serial: Migrate to
 register_console_force helper
Message-ID: <aWkVvCu74HhV7W9s@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-16-21a291bcf197@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-16-21a291bcf197@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260115_082850_669349_6A2F8B98 
X-CRM114-Status: GOOD (  23.88  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Sat 2025-12-27 09:16:23, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  drivers/tty/serial/ma35d1_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
> index 285b0fe41a86..d1e03dee5579 100644
> --- a/drivers/tty/serial/ma35d1_serial.c
> +++ b/drivers/tty/serial/ma35d1_serial.c
> @@ -633,7 +633,7 @@ static struct console ma35d1serial_console = {
>  	.write   = ma35d1serial_console_write,
>  	.device  = uart_console_device,
>  	.setup   = ma35d1serial_console_setup,
> -	.flags   = CON_PRINTBUFFER | CON_ENABLED,
> +	.flags   = CON_PRINTBUFFER,
>  	.index   = -1,
>  	.data    = &ma35d1serial_reg,
>  };
> @@ -657,7 +657,7 @@ static void ma35d1serial_console_init_port(void)
>  static int __init ma35d1serial_console_init(void)
>  {
>  	ma35d1serial_console_init_port();
> -	register_console(&ma35d1serial_console);
> +	register_console_force(&ma35d1serial_console);

Sigh, I am afraid that this is not enough.

I double checked how "ma35d1serial_console" was used. I guess
that it could get registered also via the generic uart device
driver code. I see the following:

#ifdef CONFIG_SERIAL_NUVOTON_MA35D1_CONSOLE
[...]
#define MA35D1SERIAL_CONSOLE    (&ma35d1serial_console)
#else
#define MA35D1SERIAL_CONSOLE    NULL
#endif

static struct uart_driver ma35d1serial_reg = {
[...]
	.cons         = MA35D1SERIAL_CONSOLE,
[...]
};

static int __init ma35d1serial_init(void)
{
[...]
	ret = uart_register_driver(&ma35d1serial_reg);
[...]
	ret = platform_driver_register(&ma35d1serial_driver);
[...]
}

And the gneric code:

uart_configure_port(struct uart_driver *drv, struct uart_state *state,
		    struct uart_port *port)
{
[...]
		/*
		 * If this driver supports console, and it hasn't been
		 * successfully registered yet, try to re-register it.
		 * It may be that the port was not available.
		 */
		if (port->cons && !console_is_registered(port->cons))
			register_console(port->cons);

[...]
}

, which can called via from:

  + mux_probe()
    + uart_add_one_port()
      + serial_ctrl_register_port()
	+serial_core_register_port()
	  + serial_core_add_one_port()
	    + uart_configure_port()
	      + register_console()


Honestly, I am not 100% sure. The struct console is assigned to
.cons in struct uart_driver. And uart_configure_port() function
passes port->cons from struct uart_port *port. But I believe
that they can get assigned somewhere in the maze of
the init/probe code.

I would feel more comfortable if we kept the information as
as flag in struct console so that even the generic callbacks
could use it.

Anyway, it makes sense to create a sepate flag for this
purpose, e.g. CON_FORCE or CON_FORCE_ENABLE.

>  	return 0;
>  }
>  console_initcall(ma35d1serial_console_init);

Best Regards,
Petr

