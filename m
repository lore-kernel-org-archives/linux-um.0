Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4F38D4C5.9080907@suse.cz>
Date: Mon, 13 Feb 2012 10:15:49 +0100
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
References: <1329006070-4275-1-git-send-email-richard@nod.at> <20120212191134.GQ23916@ZenIV.linux.org.uk>
In-Reply-To: <20120212191134.GQ23916@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: your mail
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, gregkh@linuxfoundation.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 02/12/2012 08:11 PM, Al Viro wrote:
> On Sun, Feb 12, 2012 at 01:21:10AM +0100, Richard Weinberger wrote:
> 
>> @@ -343,7 +267,7 @@ static irqreturn_t line_write_interrupt(int irq, void *data)
>>  {
>>  	struct chan *chan = data;
>>  	struct line *line = chan->line;
>> -	struct tty_struct *tty = line->tty;
>> +	struct tty_struct *tty = tty_port_tty_get(&line->port);
>>  	int err;
>>  
>>  	/*
>> @@ -354,6 +278,9 @@ static irqreturn_t line_write_interrupt(int irq, void *data)
>>  	spin_lock(&line->lock);
>>  	err = flush_buffer(line);
>>  	if (err == 0) {
>> +		tty_kref_put(tty);
>> +
>> +		spin_unlock(&line->lock);
>>  		return IRQ_NONE;
>>  	} else if (err < 0) {
>>  		line->head = line->buffer;
>> @@ -365,9 +292,12 @@ static irqreturn_t line_write_interrupt(int irq, void *data)
>>  		return IRQ_NONE;
>>  
>>  	tty_wakeup(tty);
>> +	tty_kref_put(tty);
>>  	return IRQ_HANDLED;
>>  }
> 
> That, BTW, smells ugly.  Note that return before the last one has no
> tty_kref_put() for a very good reason - it's under if (!tty).  And
> just as line->tty, port->tty can become NULL, so tty_port_tty_get()
> can, indeed, return NULL here.  Which makes the first tty_kref_put()
> oopsable...

Nope, it is allowed to call tty_kref_put(NULL).

regards,
-- 
js
suse labs
