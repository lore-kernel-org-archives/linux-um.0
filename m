Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgbKu-0003Vv-20
 for linux-um@lists.infradead.org; Sat, 21 Nov 2020 22:26:30 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94) (envelope-from <johannes@sipsolutions.net>)
 id 1kgbKj-00CCOJ-0h
 for linux-um@lists.infradead.org; Sat, 21 Nov 2020 23:26:17 +0100
Message-ID: <6d207ef433d5077ea7a13394a9750b1b8e137c67.camel@sipsolutions.net>
Subject: Re: [PATCH 1/4] um: simplify os_idle_sleep() and sleep longer
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sat, 21 Nov 2020 23:26:16 +0100
In-Reply-To: <20201120222625.c08aab9c34aa.I3b692c844a4ca459ee3084334a92ac5ef5b4cec4@changeid>
References: <20201120212921.880781-1-johannes@sipsolutions.net>
 <20201120222625.c08aab9c34aa.I3b692c844a4ca459ee3084334a92ac5ef5b4cec4@changeid>
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

On Fri, 2020-11-20 at 22:29 +0100, Johannes Berg wrote:
> 
> Additionally, one second isn't really all that long, and as we
> are expecting to be woken up by a signal, we can sleep longer
> and avoid doing some work every second. Bump to two minutes.

The list is down so I cannot reply to the second version (that I think I
sent) yet, but there really is no reason for this ...

We can just use

	select(0, NULL, NULL, NULL);

which can *only* be woken up by signals.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

