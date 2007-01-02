Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1exd-0006sf-6Y for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Jan 2007 00:25:30 -0800
Received: from gepetto.dc.ltu.se ([130.240.42.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H1exc-0002zr-D8
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Jan 2007 00:25:28 -0800
Message-ID: <459A1760.7010805@student.ltu.se>
Date: Tue, 02 Jan 2007 09:27:12 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
MIME-Version: 1.0
References: <200701011947.l01JlAMo020761@ccure.user-mode-linux.org>	<4599BAE1.9050804@student.ltu.se>
	<20070101182322.b365543a.rdunlap@xenotime.net>
In-Reply-To: <20070101182322.b365543a.rdunlap@xenotime.net>
Subject: Re: [uml-devel] [PATCH 4/8] UML - audio driver formatting
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
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Randy Dunlap wrote:
> On Tue, 02 Jan 2007 02:52:33 +0100 Richard Knutsson wrote:
>
>   
>> Jeff Dike wrote:
>>     
>>> Whitespace and style fixes.
>>>
>>> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>>> --
>>>  arch/um/drivers/hostaudio_kern.c |  160 +++++++++++++++++----------------------
>>>  1 file changed, 73 insertions(+), 87 deletions(-)
>>>
>>> Index: linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c
>>> ===================================================================
>>> --- linux-2.6.18-mm.orig/arch/um/drivers/hostaudio_kern.c	2006-12-29 21:13:41.000000000 -0500
>>> +++ linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c	2006-12-29 21:13:42.000000000 -0500
>>> @@ -15,11 +15,11 @@
>>>  #include "os.h"
>>>  
>>>  struct hostaudio_state {
>>> -  int fd;
>>> +	int fd;
>>>  };
>>>  
>>>  struct hostmixer_state {
>>> -  int fd;
>>> +	int fd;
>>>  };
>>>  
>>>  #define HOSTAUDIO_DEV_DSP "/dev/sound/dsp"
>>> @@ -72,12 +72,12 @@ MODULE_PARM_DESC(mixer, MIXER_HELP);
>>>  static ssize_t hostaudio_read(struct file *file, char __user *buffer,
>>>  			      size_t count, loff_t *ppos)
>>>  {
>>> -        struct hostaudio_state *state = file->private_data;
>>> +	struct hostaudio_state *state = file->private_data;
>>>  	void *kbuf;
>>>  	int err;
>>>  
>>>  #ifdef DEBUG
>>> -        printk("hostaudio: read called, count = %d\n", count);
>>> +	printk("hostaudio: read called, count = %d\n", count);
>>>  #endif
>>>  
>>>  	kbuf = kmalloc(count, GFP_KERNEL);
>>> @@ -91,7 +91,7 @@ static ssize_t hostaudio_read(struct fil
>>>  	if(copy_to_user(buffer, kbuf, err))
>>>  		err = -EFAULT;
>>>  
>>> - out:
>>> +out:
>>>   
>>>       
>> Isn't labels _suppose_ to be spaced? (due to "grep", if I'm not mistaken)...
>>     
>
> There was some noise about that (due to 'patch' IIRC).
> I tested it and could not cause a problem with labels beginning
> in column 0.  Can you?
>   
Can't say I have (even thou I have not tried so much). You seem to have 
it covered, sorry for adding to the noise.
>   
>>>  	kfree(kbuf);
>>>  	return(err);
>>>  }
>>>       
>
>
>   
Richard Knutson


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
