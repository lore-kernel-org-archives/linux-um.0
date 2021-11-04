Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1midSt-0094yb-1J
 for linux-um@lists.infradead.org; Thu, 04 Nov 2021 14:11:40 +0000
Subject: Re: [PATCH] um: use swap() to make code cleaner
References: <20211104061609.1496503-1-yang.guang5@zte.com.cn>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <7f95e669-fba3-32e6-cdb9-41fb415b3b82@cambridgegreys.com>
Date: Thu, 4 Nov 2021 14:11:22 +0000
MIME-Version: 1.0
In-Reply-To: <20211104061609.1496503-1-yang.guang5@zte.com.cn>
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
To: davidcomponentone@gmail.com, jdike@addtoit.com
Cc: richard@nod.at, johannes.berg@intel.com, yang.guang5@zte.com.cn, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>



On 04/11/2021 06:16, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---
>   arch/um/os-Linux/sigio.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
> index 9e71794839e8..1eb15f3cfdc8 100644
> --- a/arch/um/os-Linux/sigio.c
> +++ b/arch/um/os-Linux/sigio.c
> @@ -50,7 +50,7 @@ static struct pollfds all_sigio_fds;
>   
>   static int write_sigio_thread(void *unused)
>   {
> -	struct pollfds *fds, tmp;
> +	struct pollfds *fds;
>   	struct pollfd *p;
>   	int i, n, respond_fd;
>   	char c;
> @@ -77,9 +77,7 @@ static int write_sigio_thread(void *unused)
>   					       "write_sigio_thread : "
>   					       "read on socket failed, "
>   					       "err = %d\n", errno);
> -				tmp = current_poll;
> -				current_poll = next_poll;
> -				next_poll = tmp;
> +				swap(current_poll, next_poll);
>   				respond_fd = sigio_private[1];
>   			}
>   			else {
> 

You should include minmax.h for the swap macro. While there is a very significant likelihood that it will be pulled up by another something else, it is better to do that explicitly.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

