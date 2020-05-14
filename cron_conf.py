#
# This file controlls auxilary background jobs in Cerebro
# It specified values for python tools scripts fron 'cron' directory only. 
# 


#
# For STUDIO tariffs
#   
# * Garbage removed in Cerebro files in local storage
#   Must match with cargador.conf/config/catalog/del_password

CARGADOR_DEL_PASSWORD='' # password for sweeping files. 


#
# For FACTORY (own Database installation) tariffs only!
#

DB_HOST=""				# your Database server address
DB_PORT=5432			# your Database server port
DB_PSWD=""              # 'sa_sirena' password. You may reset it in pgAdmin

MAIL_FROM  = "Cerebro <noreply@your.company.com>"	# <Mail from> on Cerebro notification messages 
MAIL_SMTP  = ""			# SMTP server to send Cerebro notifications
MAIL_ADMIN = ''			# email to receive diagnostic and alert messages
MAIL_LOGIN = ''			# if SMTP needs AUTH, place it here. LEAVE empty otherwise
MAIL_PSSWD = ''			#   if MAIL_LOGIN non-empty, MAIL_PSSWD can NOT be empty


EXTERNAL_DB_ADDR = 'db.cerebrohq.com:45432' # Specify EXTERNAL Cerebro Database address. 
#   This address used in two ways^
#      1. It will sent in email-invantation to YOUR cerebro installation
#      2. It used for HTTP downloads from EMAILs. (You alse need open HTTP port, and register it in Administartor/File storages)

OPTS = {
	'db_connection_addr' : EXTERNAL_DB_ADDR

#
# Additional SMTP options for mailer
#
#	, 'smtp_port' : 25    # defaults 25 for simple and 465 for SSL. Use 587 for Exchange
# 	, 'smtp_tls' : False  # Needed for Google SMTP
#	, 'mail_log' : ''     # optional mailer log file
#	, 'mail_disable' : True # Disable Cerebro mailer

#
# Settings for Replier service
#  Replier is back-way to write messages in Cerebro by repling on email-notifation
#   In general to get this working you have to 
#      1. Create mail-box to recieve users replies
#      2. Specify POP access for replier.py script. It will extract messages and re-post its in Cerebro
#      3. enable 'Allow reply..' in Adminstartion/Universe window
#
#	, 'replier_from_addr' : 'Cerebro reply <reply@your-valid-mail-box.com>' # this address will use to reply messages
#	, 'replier_pop_addr'  : ''
#	, 'replier_pop_ssl'   : True
#	, 'replier_pop_login' : ''
#	, 'replier_pop_psswd' : ''
#	# do not change 'replier_downloader_url' unless you sure
#	, 'replier_downloader_url' : 'https://storage.cerebrohq.com/download.php?db_host=' + EXTERNAL_DB_ADDR.partition(':')[0] + '&db_port=' + EXTERNAL_DB_ADDR.partition(':')[2] + '&'
#	, 'replier_separator' : ''
#
#
#
# Settings for poll files from remote file-storage
#   ESSENTIALS pollFiles settings:
#	, 'sync_remote_cargador_host' : ''
#	, 'sync_db_user'  : ''	# set special Sync-User account. For "siteSirenaDownloadList" all Sync-User followed task are subject to sync
#	, 'sync_db_pswd'  : ''
#
#	# Optional pollFiles settings:
#	, 'sync_remote_cargador_port' : 45431
#	, 'sync_queue_name' : 'sirena' # user to display in download queue . Leave 'sirena' to hide unnattended downloads
#
#	Syncing file options:
#	, 'sync_sql_query'  : 'select hash, url from "siteSirenaDownloadList"(90*60)'
#	# for Factory may be used with caoution: "select * from \"zFileList_ForUniverse\"('<UNVERSE NAME>', '1 week'::interval)"
#
#	, 'sync_run_interval'	:1*60*60 # hour in seconds
#	, 'sync_run_after_hour'	:0		# by default runs all day
#	, 'sync_run_before_hour':24 	# this hour exluded
#	, 'sync_separator' : ''
#
#
#
#
#	LDAP user sync
#	, 'ldap_user' : ''	# User to read ldap directory
#	, 'ldap_pswd' : ''	# Ldap user password
#	, 'ldap_encoding': 'cp1251' # code page to translate from multi-bytes to Unicode
#	, 'ldap_verbose': True # Log syncing errors
#	, 'ldap_email_default_domain' : '' append this string if 'email' does not contain <@suff.ix>
}


###################################
#
# USUALLLY do not need to change
# Change if you sure only!
#
##################################

DB_USER="sa_sirena"
DB_SCHEMA="memoria"

CARGADOR_HOST="127.0.0.1"
CARGADOR_RPC_PORT=4040
CARGADOR_HTPP_PORT=4080

MAIL_USE_SSL = False		# Nowdays totally replaced with TLS

DEBUG = False;		# May used for debug
