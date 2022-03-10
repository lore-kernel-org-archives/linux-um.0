Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSK8E-00DDKD-ST
 for linux-um@lists.infradead.org; Thu, 10 Mar 2022 14:51:12 +0000
Subject: Re: [PATCH] docs: UML: Mention telnetd for port channel
References: <20220310124230.3069354-1-vincent.whitchurch@axis.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <e1709d07-6217-90b9-273a-50b32798da55@cambridgegreys.com>
Date: Thu, 10 Mar 2022 14:17:19 +0000
MIME-Version: 1.0
In-Reply-To: <20220310124230.3069354-1-vincent.whitchurch@axis.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Vincent Whitchurch <vincent.whitchurch@axis.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Jonathan Corbet <corbet@lwn.net>
Cc: kernel@axis.com, linux-um@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org



On 10/03/2022 12:42, Vincent Whitchurch wrote:
> It is not obvious from the documentation that using the "port" channel
> for the console requires telnetd to be installed (see port_connection()
> in arch/um/drivers/port_user.c).  Mention this, and the fact that UML
> will not boot until a client connects.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>   Documentation/virt/uml/user_mode_linux_howto_v2.rst | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index 2cafd3c3c6cb..d5ad96c795f6 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -664,7 +664,11 @@ one is input, the second one output.
>   * The fd channel - use file descriptor numbers for input/output. Example:
>     ``con1=fd:0,fd:1.``
>   
> -* The port channel - listen on TCP port number. Example: ``con1=port:4321``
> +* The port channel - start a telnet server on TCP port number. Example:
> +  ``con1=port:4321``.  The host must have /usr/sbin/in.telnetd (usually part of
> +  a telnetd package) and the port-helper from the UML utilities (see the
> +  information for the xterm channel below).  UML will not boot until a client
> +  connects.
>   
>   * The pty and pts channels - use system pty/pts.
>   
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

