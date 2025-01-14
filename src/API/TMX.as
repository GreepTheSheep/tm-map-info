namespace TMX {
    const string getMapByUidEndpoint = "https://trackmania.exchange/api/maps/get_map_info/uid/{id}";

    // <https://api2.mania.exchange/Method/Index/37>
    Json::Value@ GetMapFromUid(const string &in uid) {
        string url = getMapByUidEndpoint.Replace("{id}", uid);
        auto req = PluginGetRequest(url);
        req.Start();
        while (!req.Finished()) yield();
        if (req.ResponseCode() >= 400 || req.ResponseCode() < 200 || req.Error().Length > 0) {
            log_warn("[status:" + req.ResponseCode() + "] Error getting map by UID from TMX: " + req.Error());
            return null;
        }
        // log_info("Debug tmx get map by uid: " + req.String());
        return Json::Parse(req.String());
    }
}
