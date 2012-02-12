Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4F37B34F.1040307@suse.cz>
Date: Sun, 12 Feb 2012 13:40:47 +0100
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
References: <1329006070-4275-1-git-send-email-richard@nod.at> <20120212010211.GN23916@ZenIV.linux.org.uk>
In-Reply-To: <20120212010211.GN23916@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: your mail
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, gregkh@linuxfoundation.org, Jiri Slaby <jirislaby@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 02/12/2012 02:02 AM, Al Viro wrote:
> On Sun, Feb 12, 2012 at 01:21:10AM +0100, Richard Weinberger wrote:
>> +++ b/arch/um/drivers/line.c
>> @@ -19,19 +19,29 @@ static irqreturn_t line_interrupt(int irq, void *data)
>>  {
>>  	struct chan *chan = data;
>>  	struct line *line = chan->line;
>> +	struct tty_struct *tty;
>> +
>> +	if (line) {
>> +		tty = tty_port_tty_get(&line->port);
>> +		chan_interrupt(&line->chan_list, &line->task, tty, irq);
>> +		tty_kref_put(tty);
>> +	}
>>  
>> -	if (line)
>> -		chan_interrupt(&line->chan_list, &line->task, line->tty, irq);
>>  	return IRQ_HANDLED;
>>  }
> 
> Is tty_kref_put() safe in interrupt?  Here it seems to be OK, but in other
> callers...  More or less at random: drivers/tty/serial/lantiq.c has it
> called from lqasc_rx_int().  It seems to be possible to have it end up
> calling ->ops->shutdown() and in this case that'd be lqasc_shutdown().
> Which does a bunch of free_irq(), including the ->rx_irq, i.e. the one
> we have it called from.  Alan?

I'm not Alan, but will reply anyway. Yes, it is safe (unless the driver
does something tricky). In the driver you mention, this is uart_ops,
called from tty_port_operations' ->shutdown. And that's a different from
tty_operations' ->shutdown.

Yes, there are:
* tty->ops
* tty_port->ops
* uart_port->ops

uart_port->ops->shutdown is supposed to tear down interrupts like in
lantiq.c. It is called from tty_port->ops->shutdown. And that one is
allowed to be called only from user context (tty->ops->close and
tty->ops->hangup).

thanks,
-- 
js
suse labs
