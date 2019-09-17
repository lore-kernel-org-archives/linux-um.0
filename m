Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iADdU-0005Hf-Bi
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 13:35:18 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1iADdT-0005MV-1l
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 15:35:15 +0200
Message-ID: <a8a2a033d8dc988c34d321425b7d0baa65b8df81.camel@sipsolutions.net>
Subject: Re: [RFC v3 2/2] um: implement time-travel=ext
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 17 Sep 2019 15:35:14 +0200
In-Reply-To: <1568726354-I0c06fae89d77d5b272dfb4c7ea64641b597b5c7b@changeid>
References: <20190917132943.20102-1-johannes@sipsolutions.net>
 <1568726354-I0c06fae89d77d5b272dfb4c7ea64641b597b5c7b@changeid>
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

On Tue, 2019-09-17 at 15:29 +0200, Johannes Berg wrote:
> 
>  struct virtio_uml_vq_info {
>  	int kick_fd, call_fd;
>  	char name[32];
> +#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
> +	struct virtqueue *vq;
> +	vq_callback_t *callback;
> +	struct time_travel_event defer;
> +#endif

There's a bit of a question here - should I put all these ifdefs?

It *should* compile fine without them, and throw away the unused
functions, but this structure will still be bigger, and the vq
initialization will still be done. Everything else should go away since
time_travel_mode is tested (and is defined to NONE) / empty inlines are
called if CONFIG_UML_TIME_TRAVEL_SUPPORT isn't set.

Though, come to think of it, I probably broke modular builds again here.

Anyway, I won't send a new version soon I think, comments welcome and
I'll see how the qemu changes progress.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

