Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <CAKiyQA_Lfiv8ex3+nRn+U386HPsgjo_iYB24kixDAwt7Qeuqng@mail.gmail.com>
References: <CAKiyQA_p+wCCYEmsrau7X=V8mtcY1+MdpDX9RZz8PLB0sQHKuA@mail.gmail.com>
	<CAFLxGvymOuLznwat+4VdWPZJX4bJ=EecJwEezd_DgoRkm3FBTA@mail.gmail.com>
	<CAKiyQA_Lfiv8ex3+nRn+U386HPsgjo_iYB24kixDAwt7Qeuqng@mail.gmail.com>
Date: Thu, 23 Aug 2012 17:52:45 +0200
Message-ID: <CAFLxGvzmyfzG-fx9BMzfO1gFjBjMnP0eJeGJN_B_Zj=EMe7r8Q@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [uml-user] TSC register
To: Dragos Diaconescu <diaconescud@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Wed, Aug 22, 2012 at 6:34 PM, Dragos Diaconescu
<diaconescud@gmail.com> wrote:
>    at an interval of some nanoseconds and to use the ndelay function. I saw
> that in the kernel implementation
>    for the uml there is no "delay_tsc"
>    function and there is only the "delay_loop" function. I am wondering why
> the delay_tsc is not implemented. Is it not
>    possible to read the TSC register?
>    I would need this for having a nanosecond precision.

You can access TSC from user space, so also UML can read it.
There is no delay_tsc() in UML because nobody cared so far.
Feel free to implement it and send me a patch. :-)

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

