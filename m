Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIRtc-0008F4-9Y
 for linux-um@lists.infradead.org; Wed, 16 Sep 2020 07:30:29 +0000
Subject: Re: [PATCH v2 2/2] um: time-travel: return the sequence number in ACK
 messages
References: <20200910093113.90307-1-johannes@sipsolutions.net>
 <20200910113049.bb7bf508a6ad.Ib2bcca1371247b2f8643f35fb85ca5051addd8cc@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <f0b15a4c-eb19-eb92-e25a-00359c736db4@kot-begemot.co.uk>
Date: Wed, 16 Sep 2020 08:30:17 +0100
MIME-Version: 1.0
In-Reply-To: <20200910113049.bb7bf508a6ad.Ib2bcca1371247b2f8643f35fb85ca5051addd8cc@changeid>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>



On 10/09/2020 10:31, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> For external time travel, the protocol says to return the
> incoming sequence number in the ACK message to aid debugging,
> so do that.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/kernel/time.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
> index c07436e89e59..3d109ff3309b 100644
> --- a/arch/um/kernel/time.c
> +++ b/arch/um/kernel/time.c
> @@ -106,6 +106,7 @@ static void time_travel_handle_message(struct um_timetravel_msg *msg,
>   		break;
>   	}
>   
> +	resp.seq = msg->seq;
>   	os_write_file(time_travel_ext_fd, &resp, sizeof(resp));
>   }
>   
> 
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

