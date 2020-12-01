Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk3M0-0003dQ-Us
 for linux-um@lists.infradead.org; Tue, 01 Dec 2020 10:57:53 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94) (envelope-from <johannes@sipsolutions.net>)
 id 1kk3Lx-000Sor-LK
 for linux-um@lists.infradead.org; Tue, 01 Dec 2020 11:57:49 +0100
Message-ID: <a4c36b0f08839904a37dd5419a0e85cc96ae90a9.camel@sipsolutions.net>
Subject: Re: [PATCH v6 1/5] um: simplify os_idle_sleep() and sleep longer
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 01 Dec 2020 11:57:32 +0100
In-Reply-To: <20201130131520.3a0d2a5443a2.I3b692c844a4ca459ee3084334a92ac5ef5b4cec4@changeid>
References: <20201130121550.173513-1-johannes@sipsolutions.net>
 <20201130131520.3a0d2a5443a2.I3b692c844a4ca459ee3084334a92ac5ef5b4cec4@changeid>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

On Mon, 2020-11-30 at 13:15 +0100, Johannes Berg wrote:
> 
> -void os_idle_sleep(unsigned long long nsecs)
> +void os_idle_sleep(void)
>  {
> -	struct timespec ts = {
> -		.tv_sec  = nsecs / UM_NSEC_PER_SEC,
> -		.tv_nsec = nsecs % UM_NSEC_PER_SEC
> -	};
> -
> -	/*
> -	 * Relay the signal if clock_nanosleep is interrupted.
> -	 */
> -	if (clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL))
> -		deliver_alarm();
> +	select(0, NULL, NULL, NULL, NULL);
> 

I found out about the pause() syscall the other day. Maybe we should use
that here? It's basically equivalent, though with a shorter kernel code
path?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

